class CreateMarkets < ActiveRecord::Migration[5.2]
  def change
    create_table :markets do |t|
      t.string :name

      t.timestamps
    end
    add_index :markets, :name, unique: true
  end
end
