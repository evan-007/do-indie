class AddAreaToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :area, :string
  end
end
