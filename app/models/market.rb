class Market < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
