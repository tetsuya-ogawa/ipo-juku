class CompanyDecorator < Draper::Decorator
  delegate_all

  def meta_title
  end

  def meta_description
    "#{name}は#{ipo_information.listing_date.strftime('%m月%d日')}が上場し、上場市場は#{ipo_information.market.name}で主幹事は#{main_secretary&.name}です。"
  end

  def sp_display_sales_columns
    { amount_of_sales: '売上高', ordinary_income: '経常利益', profit: '純利益' }
  end
end
