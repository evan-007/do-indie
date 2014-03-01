class AddAttachmentAvatarToBands < ActiveRecord::Migration
  def self.up
    change_table :bands do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :bands, :avatar
  end
end
