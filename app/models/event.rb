class Event < ActiveRecord::Base
	validates :name, presence: true
	
	belongs_to :user
	belongs_to :venue
	belongs_to :city

	has_many :event_bands, dependent: :destroy
	has_many :bands, through: :event_bands
	has_many :event_managers, dependent: :destroy
	has_many :users, through: :event_managers

	scope :upcoming, -> { where(["date > ?", Date.yesterday]) }
	scope :past, -> { where(["date < ? ", Date.today]) }
	scope :approved, -> { where(approved: true) }
	scope :unapproved, -> { where(approved: false) }

	after_save :approval_notification, if: :approved_changed?
	after_create :make_manager
	paginates_per 50
  self.per_page = 15
  
	accepts_nested_attributes_for :event_bands, :venue, :bands
	has_attached_file :avatar, :styles => { :large => "900x900>", :medium => "300x300#", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	
	accepts_nested_attributes_for :bands
	accepts_nested_attributes_for :venue
	accepts_nested_attributes_for :city
	extend FriendlyId
	friendly_id :name, use: :slugged

  attr_reader :band_tokens, :venue_tokens, :city_tokens

	def band_tokens=(tokens)
		self.band_ids = Band.ids_from_tokens(tokens)
	end
  
  def venue_tokens=(tokens)
    unless Venue.ids_from_tokens(tokens).blank?
      self.venue = Venue.find((Venue.ids_from_tokens(tokens)))
    else
      self.venue = nil
    end
  end

  def city_tokens=(tokens)
    unless City.ids_from_tokens(tokens).blank?
      self.city = City.find((City.ids_from_tokens(tokens)))
    else
      self.city = nil
    end
  end

  def start_time
  	self.date
  end
  
  def upcoming_has_city
    where.not(city_id: nil)
  end

	def self.date_search(date)
    unless date.blank?
      events = where(date: Date.parse(date)).order(date: :asc)
    else
    	events = []
		end
	end


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
			    	self.approved.where("name ilike :q or ko_name ilike :q", q: "%#{search}%").order(
      	approved: :asc
		    ).page page_number
    else
			order(approved: :asc).page page_number
    end
	end

	def self.index_search(query)
    if query.present?
      self.approved.where("name ilike :q or ko_name ilike :q", q: "%#{query}%").order(date: :asc).group("id")
    else
      approved.upcoming.order(date: :asc).group("id")
    end
	end

	def self.past_index_search(query, page_number)
    if query.present?
      self.approved.where("name ilike :q or ko_name ilike :q", q: "%#{query}%").order(date: :desc).page page_number
    else
      approved.past.order(date: :desc).page page_number
    end
	end

	def self.search_by_date(start_date, end_date)
		Event.where(["date > ?", start_date]).where(["date < ? ", end_date]).order(date: :asc)
	end

	def make_manager
		unless self.user.blank?
			EventManager.create!(event_id: self.id, user_id: self.user.id, approved: true)
		end
	end

	private

    def approval_notification
    	if self.approved == true && self.user != nil
	    	UserMailer.event_approved_email(self).deliver
	    end
		end
end
