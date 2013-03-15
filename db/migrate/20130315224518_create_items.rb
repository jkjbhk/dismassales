class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :code
      t.string :title
      t.references :category
      t.string :description
      t.decimal :price
      t.boolean :enabled
      t.boolean :show_on_home

      t.timestamps
    end
    add_index :items, :category_id
  end
end
