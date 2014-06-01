class EventBand < ActiveRecord::Base
  belongs_to :band, counter_cache: true
  belongs_to :event, counter_cache: true
end
