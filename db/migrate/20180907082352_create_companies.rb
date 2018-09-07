class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.datetime :establishment_date
      t.string :president_name
      t.string :home_page
      t.string :address
      t.text :business_content

      t.timestamps
    end
  end
end
