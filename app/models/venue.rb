class Venue < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	has_many :event_venues
	has_many :events, through: :event_venues

	paginates_per 100 #fix pagination

	has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	geocoded_by :address
	after_validation :geocode, if: :address_changed? 

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
