class Company < ApplicationRecord
  validates :home_page, allow_blank: true, url: true
  has_one :ipo_information
  has_many :company_sales
  validates :code, presence: true
end
