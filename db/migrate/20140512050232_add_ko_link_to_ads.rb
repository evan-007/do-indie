class AddKoLinkToAds < ActiveRecord::Migration
  def change
    add_column :ads, :ko_link, :string
  end
end
