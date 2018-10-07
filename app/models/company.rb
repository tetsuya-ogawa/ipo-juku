class Company < ApplicationRecord
  belongs_to :industry
  has_one :ipo_information
  has_many :company_sales
  has_many :company_audit_corporations
  has_many :audit_corporations, through: :company_audit_corporations
  has_many :secretaries
  has_many :securities_companies, through: :secretaries
  has_many :shareholders
  validates :name, presence: true
  validates :code, presence: true
  validates :home_page, allow_blank: true, url: true


  scope :order_by_listed, lambda {
    joins(:ipo_information).order('ipo_informations.listing_date desc')
  }

  def to_param
    code
  end

  def main_secretary
    secretaries.find_by(is_main?: true)&.securities_company
  end

  def sales_with(kind)
    company_sales.group_by { |sales| sales.kind }[kind.to_s]
  end

  def has_linking?
    # 連結の売り上げが一つでも存在すれば連結ありと判断
    company_sales.group_by { |sales| sales.kind }['linking'].map(&:amount_of_sales).compact.present?
  end
end
