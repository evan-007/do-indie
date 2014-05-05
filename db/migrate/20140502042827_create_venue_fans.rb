class CreateVenueFans < ActiveRecord::Migration
  def change
    create_table :venue_fans do |t|
      t.references :user, index: true
      t.references :venue, index: true

      t.timestamps
    end
  end
end
