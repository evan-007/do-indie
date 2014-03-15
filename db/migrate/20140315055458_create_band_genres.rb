class CreateBandGenres < ActiveRecord::Migration
  def change
    create_table :band_genres do |t|
      t.references :band, index: true
      t.references :genre, index: true

      t.timestamps
    end
  end
end
