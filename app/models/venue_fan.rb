class VenueFan < ActiveRecord::Base
  belongs_to :user
  belongs_to :venue
  validates_presence_of :user_id, :venue_id
end
