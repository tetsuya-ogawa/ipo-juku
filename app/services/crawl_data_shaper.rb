class CrawlDataShaper
  def initialize
    @tokyo_ipo_crawler = Crawler::TokyoIpoCrawler.new
    @yasashi_ipo_crawler = Crawler::YasashiIpoCrawler.new
  end


  def exec
    crawl!
    bundle_by_code
  end

  private

  def crawl!
    @tokyo_ipo_crawler.crawl!
    @yasashi_ipo_crawler.crawl!
  end

  def bundle_by_code
     {}.tap do |hash|
      @tokyo_ipo_crawler.scrapers.each do |scraper|
        yasashi_ipo_scraper = @yasashi_ipo_crawler.scrapers.select { |y_s| y_s.code == scraper.code }&.[](0)
        if yasashi_ipo_scraper.nil?
          next
        end
        hash[scraper.code] = build_attribute({ tokyo_ipo: scraper, yasashi_ipo: yasashi_ipo_scraper })
      end
    end
  end

  def build_attribute(scrapers_with_site)
    attributes = [:company, :ipo_information, :company_sales, :shareholder, :audit_corporation, :secretary, :market, :industry]
    {}.tap do |hash|
      attributes.each { |attribute| hash[attribute] = send("#{attribute}_attribute", scrapers_with_site) }
    end
  end

  def company_attribute(scrapers_with_site)
    { name: scrapers_with_site[:tokyo_ipo].name,
      code: scrapers_with_site[:tokyo_ipo].code,
      establishment_date: scrapers_with_site[:tokyo_ipo].company_data[:date],
      president_name: scrapers_with_site[:tokyo_ipo].company_data[:representative],
      home_page: scrapers_with_site[:tokyo_ipo].company_data[:home_page],
      address: scrapers_with_site[:tokyo_ipo].company_data[:address],
      business_content: scrapers_with_site[:tokyo_ipo].business_content }
  end

  def ipo_information_attribute(scrapers_with_site)
    { listing_date: scrapers_with_site[:tokyo_ipo].listed_date,
      public_shares: scrapers_with_site[:yasashi_ipo].public_shares,
      sold_shares: scrapers_with_site[:yasashi_ipo].sold_shares,
      winning_shares: scrapers_with_site[:yasashi_ipo].winning_shares,
      provisional_condition_start: scrapers_with_site[:yasashi_ipo].provisional_condition&.[](0),
      provisional_condition_end: scrapers_with_site[:yasashi_ipo].provisional_condition&.[](1),
      public_offering_price: scrapers_with_site[:yasashi_ipo].public_offering_price,
      lottery_period_start: scrapers_with_site[:yasashi_ipo].lottery_period&.[](0),
      lottery_period_end: scrapers_with_site[:yasashi_ipo].lottery_period&.[](1),
      winning_date: scrapers_with_site[:yasashi_ipo].winning_date,
      purchase_period_start: scrapers_with_site[:yasashi_ipo].purchase_period&.[](0),
      purchase_period_end: scrapers_with_site[:yasashi_ipo].purchase_period&.[](1),
      initial_price: scrapers_with_site[:yasashi_ipo].initial_price,
      r_f_rate: scrapers_with_site[:tokyo_ipo].r_f_rate,
      trading_unit: scrapers_with_site[:tokyo_ipo].trading_unit }
  end

  def company_sales_attribute(scrapers_with_site)
    scrapers_with_site[:tokyo_ipo].sales_data
  end

  def shareholder_attribute(scrapers_with_site)
    scrapers_with_site[:yasashi_ipo].shareholders
  end

  def audit_corporation_attribute(scrapers_with_site)
    scrapers_with_site[:tokyo_ipo].company_data[:audit_corporation].map{ |data| { name: data } }
  end

  def secretary_attribute(scrapers_with_site)
    scrapers_with_site[:yasashi_ipo].secretaries
  end

  def market_attribute(scrapers_with_site)
    { name: scrapers_with_site[:yasashi_ipo].market }
  end

  def industry_attribute(scrapers_with_site)
      { name: scrapers_with_site[:tokyo_ipo].industry }
  end
end
