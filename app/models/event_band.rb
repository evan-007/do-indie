class EventBand < ActiveRecord::Base
  belongs_to :band
  belongs_to :event
  validates :band_id, presence: true
  validates :event_id, presence: true
end
