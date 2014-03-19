class AddApprovedToBands < ActiveRecord::Migration
  def change
    add_column :bands, :approved, :boolean, default: false
  end
end
