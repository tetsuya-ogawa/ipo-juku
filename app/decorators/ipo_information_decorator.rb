class IpoInformationDecorator < Draper::Decorator
  delegate_all

  def provisional_condition_period
    if provisional_condition_start.present? && provisional_condition_end.present?
      "#{provisional_condition_start} ~ #{provisional_condition_end}"
    else
      '未公開'
    end
  end
end
