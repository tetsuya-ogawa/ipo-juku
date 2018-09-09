require 'open-uri'
require 'kconv'
require 'uri'

module Crawler
  class YasashiIpoCrawler < IpoCrawler
    attr_accessor :scrapers
    def initialize(url: 'https://www.ipokiso.com/company/schedule.html')
      super(url: url)
    end

    def crawl!
      @scrapers = [].tap do |array|
        @company_urls.each do |url|
          array << YasashiIpoScraper.new(url: url)
        end
      end
    end

    private

    def set_company_urls
      (@company_urls ||= []).tap do |array|
        @doc.css('.tableHead table.sche a').each do |content|
          array << "#{@scheme}://#{@host}#{content.attributes['href'].value}"
        end
      end
    end
  end
end
