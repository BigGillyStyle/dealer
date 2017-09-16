class AddPrimaryToImage < ActiveRecord::Migration[4.2]
  def change
    add_column :images, :primary, :boolean, default: false
  end
end
