class CreateEventVenues < ActiveRecord::Migration
  def change
    create_table :event_venues do |t|
      t.references :venue, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
