class Genre < ActiveRecord::Base
	validates :name, uniqueness: true
	has_many :band_genres
	has_many :bands, through: :band_genres
end
