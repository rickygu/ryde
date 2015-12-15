class AddLocationToRide < ActiveRecord::Migration
  def change
    add_column :rides, :lat, :float
    add_column :rides, :lng, :float
  end
end
