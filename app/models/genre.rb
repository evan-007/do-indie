class Genre < ActiveRecord::Base
	validates :name, uniqueness: true, presence: true
	has_many :band_genres, dependent: :destroy
	has_many :bands, through: :band_genres

	def self.search_and_order(search, page_number)
    if search
		where("name LIKE ?", "%#{search.downcase}%").order(
      	name: :asc
	    ).page page_number
    else
		order(name: :asc).page page_number
    end
end
end