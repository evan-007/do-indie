class AddBandToYoutubes < ActiveRecord::Migration
  def change
    add_reference :youtubes, :band, index: true
  end
end
