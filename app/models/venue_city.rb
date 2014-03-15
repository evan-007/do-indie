class VenueCity < ActiveRecord::Base
  belongs_to :venue
  belongs_to :city
  validates :venue_id, presence: true
  validates :city_id, presence: true
end
