class City < ActiveRecord::Base
	validates :en_name, uniqueness: true, presence: true
	has_many :venue_cities, dependent: :destroy
	has_many :venues, through: :venue_cities
	has_many :events, dependent: :destroy

	def self.admin_search(search, page_number)
		if search
			where("name LIKE ?", "%#{search.downcase}%").order(
				ko_name: :desc
				).page page_number
		else
			order(ko_name: :desc).page page_number
		end
	end
end
