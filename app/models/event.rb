class Event < ActiveRecord::Base
	validates :name, presence: true
	belongs_to :venue

	has_many :event_bands
	has_many :bands, through: :event_bands
	# has_many :event_venues
	# has_many :venues, through: :event_venues
end
