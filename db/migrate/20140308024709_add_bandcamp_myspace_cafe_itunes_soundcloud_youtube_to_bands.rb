class AddBandcampMyspaceCafeItunesSoundcloudYoutubeToBands < ActiveRecord::Migration
  def change
    add_column :bands, :myspace, :string
    add_column :bands, :bandcamp, :string
    add_column :bands, :cafe, :string
    add_column :bands, :itunes, :string
    add_column :bands, :soundcloud, :string
    add_column :bands, :youtube, :string
  end
end
