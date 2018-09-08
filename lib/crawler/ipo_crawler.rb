# require 'open-uri'
# require 'kconv'
# require 'nokogiri'
# require 'uri'
module Crawler
  class IpoCrawler
    attr_reader :html, :doc, :company_urls

    def initialize(url:)
      @url = url
      @scheme = URI.parse(url).scheme
      @host = URI.parse(url).host
      @html = open(url, &:read).toutf8
      @doc = Nokogiri::HTML.parse(@html, nil, 'utf-8')
      set_company_urls
    end

    private

    def set_company_urls
      raise 'define method :set_company_urls !'
    end
  end
end

