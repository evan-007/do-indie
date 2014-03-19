class Event < ActiveRecord::Base
	validates :name, presence: true
	extend FriendlyId
	friendly_id :name, use: :slugged

	belongs_to :venue
	has_many :event_bands
	has_many :bands, through: :event_bands
	has_many :event_managers
	has_many :users, through: :event_managers
	scope :upcoming, -> {where(["date > ?", Date.yesterday])}
	# has_many :event_venues
	# has_many :venues, through: :event_venues
	paginates_per 100 #fix pagination
	accepts_nested_attributes_for :event_bands, :venue, :bands
	has_attached_file :avatar, :styles => { :large => "900x900>", :medium => "300x300#", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	
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
