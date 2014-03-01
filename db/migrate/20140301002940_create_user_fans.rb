class CreateUserFans < ActiveRecord::Migration
  def change
    create_table :user_fans do |t|
      t.references :band, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
