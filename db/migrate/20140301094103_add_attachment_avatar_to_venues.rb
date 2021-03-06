class AddAttachmentAvatarToVenues < ActiveRecord::Migration
  def self.up
    change_table :venues do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :venues, :avatar
  end
end
