class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :description
      t.text :body, null: false
      t.boolean :is_published, null: false, default: true

      t.timestamps
    end
  end
end
