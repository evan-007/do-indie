class AddKoreanNameCityEbCityKoEmailTwitterToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :korean_name, :string
    add_column :venues, :city_en, :string
    add_column :venues, :city_ko, :string
    add_column :venues, :email, :string
    add_column :venues, :twitter, :string
  end
end
