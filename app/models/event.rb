class Event < ActiveRecord::Base
	validates :name, presence: true
	belongs_to :venue

	paginates_per 100 #fix pagination

	has_many :event_bands
	has_many :bands, through: :event_bands
	# has_many :event_venues
	# has_many :venues, through: :event_venues

	
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
