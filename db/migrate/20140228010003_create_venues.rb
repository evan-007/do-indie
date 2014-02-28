class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :phone
      t.text :address
      t.text :misc
      t.string :facebook
      t.string :cafe
      t.string :website

      t.timestamps
    end
  end
end
