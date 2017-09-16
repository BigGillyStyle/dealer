class AddAttachmentImageToImages < ActiveRecord::Migration[4.2]
  def self.up
    add_attachment :images, :image
  end

  def self.down
    remove_attachment :images, :image
  end
end
