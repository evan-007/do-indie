class AddFirstToSliders < ActiveRecord::Migration
  def change
    add_column :sliders, :first, :boolean, default: false
  end
end
