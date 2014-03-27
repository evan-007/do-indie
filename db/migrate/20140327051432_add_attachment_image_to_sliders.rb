class AddAttachmentImageToSliders < ActiveRecord::Migration
  def self.up
    change_table :sliders do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :sliders, :image
  end
end
