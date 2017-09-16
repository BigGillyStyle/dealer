class AddAskingPriceCentsToVehicle < ActiveRecord::Migration[4.2]
  def change
    add_column :vehicles, :asking_price_cents, :integer
  end
end
