# require 'open-uri'
# require 'kconv'
# require 'nokogiri'

module Crawler
  class TokyoIpoScraper
    TABLE_HEADINGS = { 'IPO情報' => :ipo_info,
                       '財務データ　「目論見書より」' => :financial_data,
                       'コメント' => :comment,
                       '連結子会社' => :consolidated,
                       '引受証券会社' => :underwriting_securities_company,
                       'データ' => :data,
                       '主要株主' => :major_shareholder,
                       'メモ' => :memo }


    def initialize(url:)
      @url = url
      @html = open(url, &:read).toutf8
      @doc = Nokogiri::HTML.parse(@html, nil, 'utf-8')
      set_table_with_heading
    end

    def code
      @tables[:company].css('.main_data')[0].text
    end

    def listed_date
      @tables[:company].css('.main_data')[5].text
    end

    def market
      @tables[:company].css('.main_data')[2].text
    end

    def r_f_rate
      return nil unless ipo?
      @tables[:ipo_info].css('.main_data')[4].text
    end

    def trading_unit
      ipo? ? @tables[:ipo_info].css('.main_data')[15].text : @tables[:ipo_info].css('.main_data')[1].text
    end

    def business_content
      @tables[:company].css('.main_data')[6].text
    end

    def company_data
      @tables[:data].css('.main_data').map(&:text)
      {}.tap do |hash|
        hash[:date] = @tables[:data].css('.main_data')[0].text
        hash[:address] = @tables[:data].css('.main_data')[1].text
        hash[:phone] = @tables[:data].css('.main_data')[2].text
        hash[:representative] = @tables[:data].css('.main_data')[3].text
        hash[:home_page] = @tables[:data].css('.main_data')[4].text
        hash[:audit_corporation] = @tables[:data].css('.main_data')[5..7].map{ |a_c| a_c.text.gsub(' ', '') }.reject(&:empty?)
      end
    end

    def sales_data
      sales = []
      sales_per_stock = []
      @tables[:financial_data].css('.main_data')[0..35].map(&:text).each_slice(9) do |sale|
        sales << build_sales_data(sale)
      end
      @tables[:financial_data].css('.main_data')[36..59].map(&:text).each_slice(8) do |sale|
        sales_per_stock << build_sales_data_per_stock(sale)
      end
      combined = sales_per_stock.each_with_index do |sale, index|
        sale[:linking].merge!(sales[index][:linking])
        sale[:unit].merge!(sales[index][:unit])
      end
    end

    def ipo?
      ipo_date = @tables[:company].css('.main_data')[5].text
      Date.new(*ipo_date.split('/').map(&:to_i)) <= Date.today
    end

    private

    def set_table_with_heading
      @tables ||= {}
      @doc.css('.ipodatatable').each do |content|
        @tables[TABLE_HEADINGS[(content.css('h1').first || content.css('.h2_subtitle_ipodetail').first).text] || :company] = content
      end
    end

    def build_sales_data(sales_data)
      {}.tap do |hash|
        hash[:fiscal_month] = sales_data[0]
        hash[:linking] = { amount_of_sales: sales_data[1], ordinary_income: sales_data[2], profit: sales_data[3], asset: sales_data[4] }
        hash[:unit] = { amount_of_sales: sales_data[5], ordinary_income: sales_data[6], profit: sales_data[7], asset: sales_data[8] }
      end
    end

    def build_sales_data_per_stock(sales_data)
      {}.tap do |hash|
        hash[:fiscal_month] = sales_data[0]
        hash[:linking] = { profit_per_stock: sales_data[2], asset_per_stock: sales_data[3] }
        hash[:unit] = { profit_per_stock: sales_data[5], asset_per_stock: sales_data[6] }
      end
    end
  end
end