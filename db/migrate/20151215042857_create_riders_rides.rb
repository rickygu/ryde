class CreateRidersRides < ActiveRecord::Migration
  def change
    create_table :riders_rides do |t|
      t.integer :rider_id
      t.integer :ride_id
    end
  end
end
