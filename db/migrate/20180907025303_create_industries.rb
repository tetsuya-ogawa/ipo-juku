class CreateIndustries < ActiveRecord::Migration[5.2]
  def change
    create_table :industries do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :industries, :name, unique: true
  end
end
