class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.integer :number, null: false
      t.text :process, null: false
      t.references :recipe, foreign_key: true
      t.timestamps
    end
  end
end
