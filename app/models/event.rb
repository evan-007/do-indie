class Event < ActiveRecord::Base
	validates :name, presence: true
	extend FriendlyId
	friendly_id :name, use: :slugged
	belongs_to :user
	belongs_to :venue
	has_many :event_bands
	has_many :bands, through: :event_bands
	has_many :event_managers
	has_many :users, through: :event_managers
	scope :upcoming, -> { where(["date > ?", Date.yesterday]) }
	scope :past, -> { where(["date < ? ", Date.today]) }
	scope :approved, -> { where(approved: true) }
	scope :unapproved, -> { where(approved: false) }
	after_save :approval_notification, if: :approved_changed?

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
		    ).approved.upcoming.page page_number
	    else
			order(name: :asc).approved.upcoming.page page_number
	    end
	end

	def self.admin_search(search, page_number)
	    if search
			where("name LIKE ?", "%#{search.downcase}%").order(
	      	approved: :asc
		    ).page page_number
	    else
			order(approved: :asc).page page_number
	    end
	end

	def self.index_search(query, page_number)
	    if query.present?
	      self.approved.upcoming.fuzzy_search(query).page page_number
	    else
	      approved.upcoming.order(approved: :asc).page page_number
	    end
	end

	def self.past_index_search(query, page_number)
	    if query.present?
	      self.approved.past.fuzzy_search(query).page page_number
	    else
	      approved.past.order(approved: :asc).page page_number
	    end
	end

	def self.search_by_date(start_date, end_date)
		Event.where(["date > ?", start_date]).where(["date < ? ", end_date]).order(date: :asc)
	end

	private

	    def approval_notification
	    	if self.approved == true && self.user != nil
		    	UserMailer.event_approved_email(self).deliver
		    end
		end
end
