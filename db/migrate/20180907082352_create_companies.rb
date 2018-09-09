class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.date :establishment_date
      t.string :president_name
      t.string :home_page
      t.string :address
      t.string :code, null: false
      t.text :business_content

      t.timestamps
    end
  end
end
