class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :en_name
      t.string :ko_name

      t.timestamps
    end
  end
end
