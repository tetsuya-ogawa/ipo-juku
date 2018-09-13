class CreateSecretaries < ActiveRecord::Migration[5.2]
  def change
    create_table :secretaries do |t|
      t.references :company, foreign_key: true
      t.references :securities_company, foreign_key: true
      t.decimal :rate, precision: 4, scale: 2
      t.timestamps
    end
    add_index :secretaries, [:company_id, :securities_company_id], unique: true, name: 'unique_company_id_securities_company_id'
  end
end
