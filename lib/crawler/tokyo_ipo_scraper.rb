require 'open-uri'
require 'kconv'

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
      border_idxs = []
      @tables[:financial_data].css('.main_data').each_with_index do |data, index|
        border_idxs << index if data.text.include?('直近四半期') || data.text.include?('今期中間')
      end
      @tables[:financial_data].css('.main_data')[0..border_idxs[0] + 8].map(&:text).each_slice(9) do |sale|
        sales << build_sales_data(sale)
      end
      @tables[:financial_data].css('.main_data')[border_idxs[0] + 9..border_idxs[1] - 1].map(&:text).each_slice(8) do |sale|
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
      fixed_sales_data = sales_data.map do |data|
        data == '-' ? nil : data.delete(',')
      end
      {}.tap do |hash|
        hash[:fiscal_month] = fixed_sales_data[0]
        hash[:linking] = { amount_of_sales: fixed_sales_data[1], ordinary_income: fixed_sales_data[2], profit: fixed_sales_data[3], asset: fixed_sales_data[4] }
        hash[:unit] = { amount_of_sales: fixed_sales_data[5], ordinary_income: fixed_sales_data[6], profit: fixed_sales_data[7], asset: fixed_sales_data[8] }
      end
    end

    def build_sales_data_per_stock(sales_data)
      fixed_sales_data = sales_data.map do |data|
        %w(- -).include?(data) ? nil : data.delete(',')
      end
      {}.tap do |hash|
        hash[:fiscal_month] = fixed_sales_data[0]
        hash[:linking] = { profit_per_stock: fixed_sales_data[2], asset_per_stock: fixed_sales_data[3] }
        hash[:unit] = { profit_per_stock: fixed_sales_data[5], asset_per_stock: fixed_sales_data[6] }
      end
    end
  end
end
