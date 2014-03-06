class AddGenreToBands < ActiveRecord::Migration
  def change
    add_column :bands, :genre, :string
  end
end
