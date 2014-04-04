class TaggedBand < ActiveRecord::Base
  belongs_to :band
  belongs_to :post
end
