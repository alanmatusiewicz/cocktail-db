class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :user_id
      t.text :preparation
      t.boolean :iba_status

      t.timestamps
    end
  end
end
