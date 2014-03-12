class CreateEventManagers < ActiveRecord::Migration
  def change
    create_table :event_managers do |t|
      t.references :user, index: true
      t.references :event, index: true
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
