class IpoInformationDecorator < Draper::Decorator
  delegate_all

  def provisional_condition_period
    if provisional_condition_start.present? && provisional_condition_end.present?
      "#{provisional_condition_start} ~ #{provisional_condition_end}"
    else
      '未公開'
    end
  end

  def lottery_period(format = '%m月%d日')
    if lottery_period_start.present? && lottery_period_end.present?
      "#{lottery_period_start.strftime(format)} ~ #{lottery_period_end.strftime(format)}"
    else
      '未公開'
    end
  end

  def purchase_period
    if purchase_period_start.present? && purchase_period_end.present?
      "#{purchase_period_start.strftime('%m月%d日')} ~ #{purchase_period_end.strftime('%m月%d日')}"
    else
      '未公開'
    end
  end

  def min_purchase_price
    val = public_offering_price.to_i * trading_unit.to_i
    val.zero? ? '-' : val
  end
end
