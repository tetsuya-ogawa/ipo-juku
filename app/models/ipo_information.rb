class IpoInformation < ApplicationRecord
  belongs_to :company
  belongs_to :market
  validates :listing_date, presence: true
end
