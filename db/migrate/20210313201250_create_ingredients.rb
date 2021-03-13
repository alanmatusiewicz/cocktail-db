class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.integer :recipe_id
      t.integer :alcohol_id
      t.float :measure_ml
      t.float :measure

      t.timestamps
    end
  end
end
