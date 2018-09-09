class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    record.errors[attribute] << 'は正しいフォーマットではありません' unless valid_url?(value)
  end

  private

  def valid_url?(url)
    begin
      val = URI.parse(url)
    rescue
      nil
    end
    %w(http https).include?(val&.scheme) && val&.host.present?
  end
end
