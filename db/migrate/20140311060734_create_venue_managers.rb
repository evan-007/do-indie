class CreateVenueManagers < ActiveRecord::Migration
  def change
    create_table :venue_managers do |t|
      t.references :user, index: true
      t.references :venue, index: true
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
