class AuditCorporation < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
