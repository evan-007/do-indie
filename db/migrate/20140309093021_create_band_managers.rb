class CreateBandManagers < ActiveRecord::Migration
  def change
    create_table :band_managers do |t|
      t.references :user, index: true
      t.references :band, index: true
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
