# require 'open-uri'
# require 'kconv'
# require 'nokogiri'
# require 'uri'
# require './ipo_crawler'
# require './yasashi_ipo_scraper'
module Crawler
  class YasashiIpoCrawler < IpoCrawler
    def initialize(url: 'https://www.ipokiso.com/company/schedule.html')
      super(url: url)
    end

    def scrape
      @company_urls.each do |url|
        yis = YasashiIpoScraper.new(url: url)
        puts yis.code
        puts yis.public_shares
        puts yis.sold_shares
        puts yis.provisional_condition
        puts yis.public_offering_price
        puts yis.lottery_application_period
        puts yis.purchase_application_period
        puts yis.shareholders
        puts yis.secretaries
        puts '='*40
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
