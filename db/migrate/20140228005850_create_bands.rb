class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name
      t.string :contact
      t.string :facebook
      t.string :twitter
      t.string :site
      t.text :en_bio
      t.text :ko_bio

      t.timestamps
    end
  end
end
