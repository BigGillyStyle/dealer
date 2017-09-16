class AddActiveToVehicles < ActiveRecord::Migration[4.2]
  def change
    add_column :vehicles, :active, :boolean, default: true
  end
end
