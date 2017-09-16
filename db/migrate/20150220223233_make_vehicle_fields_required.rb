class MakeVehicleFieldsRequired < ActiveRecord::Migration[4.2]
  def change
    [:vin, :year, :make, :model].each do |attr|
      change_column_null :vehicles, attr, false
    end
  end
end
