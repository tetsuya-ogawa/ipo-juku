class Secretary < ApplicationRecord
  belongs_to :company
  belongs_to :securities_company
end
