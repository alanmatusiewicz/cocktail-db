class CreateBottles < ActiveRecord::Migration[6.0]
  def change
    create_table :bottles do |t|
      t.integer :user_id
      t.integer :alcohol_id

      t.timestamps
    end
  end
end
