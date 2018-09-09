class CrawlDataImporter
  def initialize(params)
    @params = params
  end

  def exec # rubocop:disable all
    @params.each do |code, param|
      company = Company.find_or_create_by(code: code) do |comp|
        comp.attributes = param[:company]
      end
      IpoInformation.find_or_initialize_by(company_id: company.id) do |ipo_info|
        ipo_info.attributes = param[:ipo_information]
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
    end
  end
end
