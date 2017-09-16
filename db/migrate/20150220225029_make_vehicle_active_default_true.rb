class MakeVehicleActiveDefaultTrue < ActiveRecord::Migration[4.2]
  def up
    change_column_default :vehicles, :active, true
  end

  def down
    change_column_default :vehicles, :active, false
  end
end
