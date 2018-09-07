class CreateSecuritiesCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :securities_companies do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :securities_companies, :name, unique: true
  end
end
