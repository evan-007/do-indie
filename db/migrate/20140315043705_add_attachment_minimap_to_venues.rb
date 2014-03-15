class AddAttachmentMinimapToVenues < ActiveRecord::Migration
  def self.up
    change_table :venues do |t|
      t.attachment :minimap
    end
  end

  def self.down
    drop_attached_file :venues, :minimap
  end
end
