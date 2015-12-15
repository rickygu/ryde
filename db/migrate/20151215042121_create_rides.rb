class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :status
      t.boolean :pool
      t.integer :passengers
      t.integer :driver_id

      t.timestamps null: false
    end
  end
end
