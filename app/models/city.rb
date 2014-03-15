class City < ActiveRecord::Base
	validates :en_name, uniqueness: true, presence: true
	validates :ko_name, uniqueness: true
	has_many :venue_cities
	has_many :venues, through: :venue_cities
end
