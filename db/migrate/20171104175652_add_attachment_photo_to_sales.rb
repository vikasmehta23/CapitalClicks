class AddAttachmentPhotoToSales < ActiveRecord::Migration[5.1]
  def self.up
    change_table :sales do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :sales, :photo
  end
end
