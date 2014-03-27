class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.text :en_title
      t.text :ko_title
      t.text :en_description
      t.text :ko_description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
