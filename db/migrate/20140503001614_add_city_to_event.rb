class AddCityToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :city, index: true
  end
end
