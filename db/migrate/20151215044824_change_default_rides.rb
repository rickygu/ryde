class ChangeDefaultRides < ActiveRecord::Migration
  def change
    change_column_default :rides, :status, 0
    change_column_default :rides, :pool, false
  end
end
