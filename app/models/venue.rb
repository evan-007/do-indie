class Venue < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	validates :name, presence: true, uniqueness: true
	has_many :event_venues
	has_many :events, through: :event_venues
	has_many :venue_managers
	has_many :users, through: :venue_managers
	has_many :venue_cities
	has_many :cities, through: :venue_cities
	belongs_to :user
	scope :approved, -> { where(approved: true) }
	scope :unapproved, -> { where(approved: false) }
	scope :localized, -> { where.not(latitude: nil) }
	after_save :approval_notification, if: :approved_changed?
	after_create :make_manager

	paginates_per 100

	has_attached_file :avatar, :styles => { :large => "900x900>", :medium => "300x300#", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	has_attached_file :minimap, :styles => { :large => "900x900>", :medium => "300x300#" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :minimap, :content_type => /\Aimage\/.*\Z/

	geocoded_by :address
	after_validation :geocode, if: :address_changed? 
  
  def self.tokens(query)
    venues = where("name LIKE ?", "%#{query}%")
    if venues.empty?
  		[{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
  	else
      venues
  	end
  end
  
  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
  	tokens.split(',')
    return tokens
  end

	def self.search_and_order(search, page_number)
	    if search
			where("name LIKE ?", "%#{search.downcase}%").order(
	      	name: :asc
		    ).approved.page page_number
	    else
			order(name: :asc).approved.page page_number
	    end
	end

	def self.admin_search(search, page_number)
	    if search
	    	self.approved.where("name ilike :q or korean_name ilike :q", q: "%#{search}%").order(
	      	approved: :asc
		    ).page page_number
	    else
			order(approved: :asc).page page_number
	    end
	end

	def self.index_search(query, page_number)
	    if query.present?
	    	self.approved.where("name ilike :q or korean_name ilike :q", q: "%#{query}%").page page_number
			# self.approved.fuzzy_search(query).page page_number
	    else
			approved.order(approved: :asc).page page_number
	    end
	end

	def make_manager
		unless self.user.blank?
			VenueManager.create!(venue_id: self.id, user_id: self.user.id, approved: true)
		end
	end

	def tweets
  	@tweet_url = twitter.gsub(/^[^_]*twitter.com\//, '')
  	twitter_client.user_timeline("#{@tweet_url}").take(1)
    rescue
    []
	end

	private

		def approval_notification
			if self.approved == true && self.user != nil
		    	UserMailer.venue_approved_email(self).deliver
		    end
		end
end
