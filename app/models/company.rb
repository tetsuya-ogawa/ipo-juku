class Company < ApplicationRecord
  validates :home_page, allow_blank: true, url: true
end
