class AddSlugToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string, unique: true
    add_column :posts, :ko_title, :string
  end
end
