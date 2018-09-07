class CreateAuditCorporations < ActiveRecord::Migration[5.2]
  def change
    create_table :audit_corporations do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :audit_corporations, :name, unique: true
  end
end
