class CreateShareholders < ActiveRecord::Migration[5.2]
  def change
    create_table :shareholders do |t|
      t.references :company, foreign_key: true
      t.string :name, null: false
      t.decimal :rate, precision: 4, scale: 2, null: false
      t.timestamps
    end
  end
end
