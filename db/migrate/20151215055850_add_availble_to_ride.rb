class AddAvailbleToRide < ActiveRecord::Migration
  def change
    add_column :rides, :available_to_pool, :boolean, default: false
  end
end
