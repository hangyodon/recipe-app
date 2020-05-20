class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :image
      t.integer :calorie
      t.string :sugar
      t.timestamps
    end
  end
end
