class IpoInfomation < ApplicationRecord
  belongs_to :company
  validates :code, presence: true
  validates :listing_date, presence: true
end
