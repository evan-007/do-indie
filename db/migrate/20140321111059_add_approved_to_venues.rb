class AddApprovedToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :approved, :boolean, default: false
  end
end
