class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.integer :cook_time
      t.string :ingredients
      t.string :instructions
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
