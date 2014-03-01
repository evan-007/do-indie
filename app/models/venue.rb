class Venue < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true

	has_many :event_venues
	has_many :events, through: :event_venues
end
