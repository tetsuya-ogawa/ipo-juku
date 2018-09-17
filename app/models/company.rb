class Company < ApplicationRecord
  belongs_to :industry
  has_one :ipo_information
  has_many :company_sales
  has_many :company_audit_corporations
  has_many :audit_corporations, through: :company_audit_corporations
  has_many :secretaries
  has_many :securities_companies, through: :secretaries
  validates :name, presence: true
  validates :code, presence: true
  validates :home_page, allow_blank: true, url: true


  scope :order_by_listed, lambda {
    joins(:ipo_information).order('ipo_informations.listing_date desc')
  }
end
