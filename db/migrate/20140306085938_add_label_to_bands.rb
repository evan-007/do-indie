class AddLabelToBands < ActiveRecord::Migration
  def change
    add_column :bands, :label, :string
  end
end
