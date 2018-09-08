# require 'open-uri'
# require 'kconv'
# require 'nokogiri'
# require 'uri'
# require './ipo_crawler'
# require './tokyo_ipo_scraper'
module Crawler
  class TokyoIpoCrawler < IpoCrawler
    def initialize(url: 'http://www.tokyoipo.com/ipo/schedule.php')
      super(url: url)
    end

    def scrape
      @company_urls.each do |url|
        tis = TokyoIpoScraper.new(url: url)
        puts tis.code
        puts tis.market
        puts tis.r_f_rate
        puts tis.trading_unit
        puts tis.company_data
        puts tis.sales_data
        puts '='*35
      end
    end

    private

    def set_company_urls
      (@company_urls ||= []).tap do |array|
        @doc.css('h2.h2_ipolist_name a').each do |content|
          array << "#{@scheme}://#{@host}#{content.attributes['href'].value}"
        end
      end
    end
  end
end
