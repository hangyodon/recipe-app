class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.text :text, null: false
      t.string :image, null: false
      t.references :recipe, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
