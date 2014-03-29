class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :en_title
      t.string :ko_title
      t.text :en_description
      t.text :ko_description
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
