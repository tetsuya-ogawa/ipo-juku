class CreateCompanyAuditCorporations < ActiveRecord::Migration[5.2]
  def change
    create_table :company_audit_corporations do |t|
      t.references :company, foreign_key: true
      t.references :audit_corporation, foreign_key: true

      t.timestamps
    end
    add_index :company_audit_corporations, [:company_id, :audit_corporation_id], unique: true, name: 'unique_company_id_audit_corporation_id'
  end
end
