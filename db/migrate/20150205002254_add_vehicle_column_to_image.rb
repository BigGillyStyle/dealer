class AddVehicleColumnToImage < ActiveRecord::Migration[4.2]
  def change
    add_reference :images, :vehicle, index: true
    add_foreign_key :images, :vehicles
  end
end
