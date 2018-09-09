require 'open-uri'
require 'kconv'
require 'uri'

module Crawler
  class TokyoIpoCrawler < IpoCrawler
    attr_accessor :scrapers
    def initialize(url: 'http://www.tokyoipo.com/ipo/schedule.php')
      super(url: url)
    end

    def crawl!
      @scrapers = [].tap do |array|
        @company_urls.each do |url|
          array << TokyoIpoScraper.new(url: url)
        end
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
