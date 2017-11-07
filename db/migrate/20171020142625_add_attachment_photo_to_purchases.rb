class AddAttachmentPhotoToPurchases < ActiveRecord::Migration[5.1]
  def self.up
    change_table :purchases do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :purchases, :photo
  end
end
