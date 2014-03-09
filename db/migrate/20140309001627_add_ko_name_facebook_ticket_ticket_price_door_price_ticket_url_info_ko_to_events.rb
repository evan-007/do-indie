class AddKoNameFacebookTicketTicketPriceDoorPriceTicketUrlInfoKoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ko_name, :string
    add_column :events, :facebook, :string
    add_column :events, :ticket, :boolean
    add_column :events, :ticket_price, :string
    add_column :events, :door_price, :string
    add_column :events, :ticket_url, :string
    add_column :events, :info_ko, :text
  end
end
