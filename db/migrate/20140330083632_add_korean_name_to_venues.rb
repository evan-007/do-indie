class AddKoreanNameToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :ko_name, :string
  end
end
