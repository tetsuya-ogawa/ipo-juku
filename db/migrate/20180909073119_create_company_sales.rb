class CreateCompanySales < ActiveRecord::Migration[5.2]
  def change
    create_table :company_sales do |t|
      t.references :company, foreign_key: true
      t.datetime :period, null: false
      t.integer :kind
      t.integer :amount_of_sales
      t.integer :ordinary_income
      t.integer :profit
      t.integer :asset
      t.decimal :profit_per_stock, precision: 5, scale: 2
      t.decimal :asset_per_stock, precision: 5, scale: 2

      t.timestamps
    end
  end
end
