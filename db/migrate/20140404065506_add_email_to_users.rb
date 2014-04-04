class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :get_email, :boolean, default: true
  end
end
