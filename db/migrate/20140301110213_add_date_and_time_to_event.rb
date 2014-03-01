class AddDateAndTimeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :date, :date
    add_column :events, :time, :string
  end
end
