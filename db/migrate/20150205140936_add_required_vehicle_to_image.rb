class AddRequiredVehicleToImage < ActiveRecord::Migration[4.2]
  def change
    change_column_null :images, :vehicle_id, false
  end
end
