class EventVenue < ActiveRecord::Base
  belongs_to :venue
  belongs_to :event
  validates :event_id, presence: true
  validates :venue_id, presence: true
end
