class CompanyAuditCorporation < ApplicationRecord
  belongs_to :company
  belongs_to :audit_corporation
end
