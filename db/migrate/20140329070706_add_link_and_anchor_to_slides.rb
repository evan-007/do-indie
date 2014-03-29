class AddLinkAndAnchorToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :link, :string
    add_column :slides, :anchor, :string
  end
end
