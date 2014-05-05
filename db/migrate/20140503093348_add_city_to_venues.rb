class AddCityToVenues < ActiveRecord::Migration
  def change
    add_reference :venues, :city, index: true
  end
end
