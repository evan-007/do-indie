class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :contact
      t.string :price
      t.text :info

      t.timestamps
    end
  end
end
