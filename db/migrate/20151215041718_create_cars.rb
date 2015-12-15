class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :driver_id
      t.string :year
      t.string :brand
      t.string :model
      t.boolean :available
      t.integer :seats
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
