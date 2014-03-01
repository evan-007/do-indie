class Venue < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	has_many :event_venues
	has_many :events, through: :event_venues

	geocoded_by :address
	after_validation :geocode, if: :address_changed? 
end
