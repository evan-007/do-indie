class CreateVenueCities < ActiveRecord::Migration
  def change
    create_table :venue_cities do |t|
      t.references :venue, index: true
      t.references :city, index: true

      t.timestamps
    end
  end
end
