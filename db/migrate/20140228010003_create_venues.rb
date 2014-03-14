class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :phone
      t.text :address
      t.text :en_bio
      t.text :ko_bio
      t.string :facebook
      t.string :cafe
      t.string :website
      t.string :small_map
      t.text :en_directions
      t.text :ko_directions

      t.timestamps
    end
  end
end
