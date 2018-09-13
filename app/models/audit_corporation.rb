class AuditCorporation < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :company_audit_corporations
  has_many :companies, through: :company_audit_corporations
end
