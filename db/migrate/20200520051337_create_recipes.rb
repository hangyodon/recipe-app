class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.string :image, null: false
      t.integer :calorie, null: false
      t.string :sugar, null: false
      t.string :category, null: false
      t.timestamps
    end
  end
end
