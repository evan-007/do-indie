class CreateEventBands < ActiveRecord::Migration
  def change
    create_table :event_bands do |t|
      t.references :band, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
