class CompanySale < ApplicationRecord
  belongs_to :company
  enum kind: { linking: 0, unit: 1 }
end
