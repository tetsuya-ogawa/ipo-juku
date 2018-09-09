class IpoInformation < ApplicationRecord
  belongs_to :company
  validates :listing_date, presence: true
end
