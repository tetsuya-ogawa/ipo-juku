class Company < ApplicationRecord
  validates :home_page, allow_blank: true, url: true
  has_one :ipo_information
  has_many :company_sales
  has_many :company_audit_corporations
  has_many :audit_corporations, through: :company_audit_corporations
  has_many :secretaries
  has_many :securities_companies, through: :secretaries
  validates :name, presence: true
  validates :code, presence: true
end
