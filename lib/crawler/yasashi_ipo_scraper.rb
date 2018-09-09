require 'open-uri'
require 'kconv'

module Crawler
  class YasashiIpoScraper
    TABLE_HEADINGS = { '基本情報' => :basic_info,
                       'IPO日程と価格決定（初値予想）' => :ipo_price,
                       'IPOスケジュール' => :ipo_schedule,
                       'IPO当選株数' => :number_of_winners,
                       '幹事証券リスト（管理人独自予想あり）' => :secretary,
                       '株主構成、ロックアップなど' => :hareholder }

    def initialize(url:)
      @url = url
      @year = url.match(/\d{4}/)[0]
      @html = open(url, &:read).toutf8
      @doc = Nokogiri::HTML.parse(@html, nil, 'utf-8')
      set_table_data
    end

    def code
      @doc.css('h1').text.match(/\d\d+/)&.[](0)
    end

    def listed_date
      @tables[:company].css('.main_data')[5].text
    end

    def market
      @tables[:basic_info].css('th').each do |content|
        if content.text == '会社名'
          return content.next.next.text.match(/【.+】/)&.[](0)&.gsub(/【|】/, '')
        end
      end
    end

    def public_shares
      @tables[:number_of_winners].css('th').each do |content|
        if content.text == '公募株数'
          return content.next.next.text.gsub(/,|株/, '')
        end
      end
    end

    def sold_shares
      @tables[:number_of_winners].css('th').each do |content|
        if content.text == '売出株数（OA含む）'
          return content.next.next.text.gsub(/,|株/, '')
        end
      end
    end

    def winning_shares
      @tables[:number_of_winners].css('th').each do |content|
        if content.text == '当選株数合計'
          return content.next.next.text.gsub(/,|株/, '')
        end
      end
    end

    def provisional_condition
      @tables[:ipo_price].css('th').each do |content|
        if content.text == '仮条件'
          return nil if content.next.next.text == '未発表'
          return content.next.next.text.gsub(/,|円| /, '').split('～')
        end
      end
    end

    def public_offering_price
      @tables[:ipo_price].css('th').each do |content|
        if content.text == '公募価格'
          return nil if content.next.next.text == '未発表'
          return content.next.next.text.gsub(/,|円| /, '')
        end
      end
    end

    def lottery_application_period
      @tables[:ipo_schedule].css('th').each do |content|
        if content.text == '抽選申込期間'
          return nil if content.next.next.text == '未発表'
          return content.next.next.text.split('～').map{ |date_string| add_year_to_date_string(date_string.sub(/月/, '/').gsub(/[^0-9\/]/, '')) }
        end
      end
    end

    def purchase_application_period
      @tables[:ipo_schedule].css('th').each do |content|
        if content.text == '購入申込期間'
          return nil if content.next.next.text == '未発表'
          return content.next.next.text.split('～').map{ |date_string| add_year_to_date_string(date_string.sub(/月/, '/').gsub(/[^0-9\/]/, '')) }
        end
      end
    end

    def initial_price
      @tables[:ipo_price].css('th').each do |content|
        if content.text == '初値'
          return content.next.next.text.match(/(\d|,)+円/)&.[](0)&.gsub(/,|円| /, '')
        end
      end
    end

    def shareholders
      [].tap do |array|
        @tables[:hareholder]&.css('tr td')&.each_slice(3) do |contents|
          array << { name: contents[0].text, rate: contents[1].text.gsub(/％|%|-/, '') }
        end
      end
    end

    def secretaries
      [].tap do |array|
        @tables[:secretary]&.css('tr td')&.each_slice(5) do |contents|
          next if contents[0].text == '証券会社名'
          array << { name: contents[0].text.gsub(/\s/, ''), rate: contents[1].text.gsub(/％|%|-/, '') }
        end
      end
    end

    private

    def set_table_data
      @doc.css('.Mainbox h2')[0].next.next
      @tables ||= {}
      @doc.css('.Mainbox h2').each do |content|
        next unless TABLE_HEADINGS[content.text]
        @tables[TABLE_HEADINGS[content.text]] = content.next.next
      end
    end

    def add_year_to_date_string(date_string)
      "#{@year}/#{date_string}"
    end
  end
end