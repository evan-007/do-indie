class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.text :en_body
      t.text :ko_body
      t.string :short_title

      t.timestamps
    end
  end
end
