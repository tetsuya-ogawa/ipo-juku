class CrawlDataImporter
  def initialize(params)
    @params = params
  end

  def exec # rubocop:disable all
    @params.each do |code, param|
      company = Company.find_or_create_by(code: code) do |comp|
        comp.attributes = param[:company]
      end
      market = Market.find_or_create_by(name: param[:market][:name])
      IpoInformation.find_or_initialize_by(company_id: company.id) do |ipo_info|
        ipo_info.attributes = param[:ipo_information]
        ipo_info.market_id = market.id
      end.save
      param[:company_sales].each do |sales|
        CompanySale.find_or_initialize_by(company_id: company.id, kind: :linking, period: Date.new(*sales[:fiscal_month].split('/').map(&:to_i))) do |c_s|
          c_s.attributes = sales[:linking]
        end.save
        CompanySale.find_or_initialize_by(company_id: company.id, kind: :unit, period: Date.new(*sales[:fiscal_month].split('/').map(&:to_i))) do |c_s|
          c_s.attributes = sales[:unit]
        end.save
      end
      param[:shareholder].each do |shareholder_param|
        Shareholder.find_or_initialize_by(company_id: company.id, name: shareholder_param[:name]) do |shareholder|
          shareholder.attributes = shareholder_param
        end.save
      end
      param[:audit_corporation].each do |audit_corporation_param|
        ac = AuditCorporation.find_or_initialize_by(name: audit_corporation_param[:name])
        ac.save
        CompanyAuditCorporation.create(company: company, audit_corporation: ac) unless company.audit_corporations.pluck(:name).include?(ac.name)
      end
      param[:secretary].each do |secretary_param|
        sc = SecuritiesCompany.find_or_initialize_by(name: secretary_param[:name])
        sc.save
        Secretary.create(company: company, securities_company: sc, rate: secretary_param[:rate]) unless company.securities_companies.pluck(:name).include?(sc.name)
      end
    end
  end
end
