class CompanyDecorator < Draper::Decorator
  delegate_all

  def meta_title
  end

  def meta_description
    "#{name}は#{ipo_information.listing_date.strftime('%m月%d日')}が上場し、上場市場は#{ipo_information.market.name}で主幹事は#{main_secretary&.name}です。"
  end
end
