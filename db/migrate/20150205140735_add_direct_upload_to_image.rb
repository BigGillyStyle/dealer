class AddDirectUploadToImage < ActiveRecord::Migration[4.2]
  def change
    add_column :images, :direct_upload_url, :string, null: false
    add_column :images, :processed, :boolean, default: false, null: false
  end
end
