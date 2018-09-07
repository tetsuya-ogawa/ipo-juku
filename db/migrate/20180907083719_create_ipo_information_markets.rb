class CreateIpoInformationMarkets < ActiveRecord::Migration[5.2]
  def change
    create_table :ipo_information_markets do |t|
      t.references :ipo_infomation, foreign_key: true
      t.references :market, foreign_key: true

      t.timestamps
    end
  end
end
