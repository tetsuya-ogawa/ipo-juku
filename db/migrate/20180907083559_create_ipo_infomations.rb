class CreateIpoInfomations < ActiveRecord::Migration[5.2]
  def change
    create_table :ipo_infomations do |t|
      t.references :company, foreign_key: true
      t.string :code, null: false
      t.datetime :listing_date, null: false
      t.integer :public_shares
      t.integer :sold_shares
      t.integer :winning_shares
      t.integer :provisional_condition_start
      t.integer :provisional_condition_end
      t.integer :public_offering_price
      t.datetime :lottery_period_start
      t.datetime :lottery_period_end
      t.datetime :purchase_period_start
      t.datetime :purchase_period_end
      t.integer :initial_price
      t.decimal :r_f_rate, precision: 4, scale: 2
      t.integer :trading_unit

      t.timestamps
    end
  end
end
