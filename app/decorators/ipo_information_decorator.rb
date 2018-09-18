class IpoInformationDecorator < Draper::Decorator
  delegate_all

  def provisional_condition_period
    if provisional_condition_start.present? && provisional_condition_end.present?
      "#{provisional_condition_start} ~ #{provisional_condition_end}"
    else
      '未公開'
    end
  end

  def min_purchase_price
    val = public_offering_price.to_i * trading_unit.to_i
    val.zero? ? '-' : val
  end
end
