class AddPostIdToSlides < ActiveRecord::Migration
  def change
    add_reference :slides, :post, index: true
  end
end
