class Band < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	has_many :user_fans, dependent: :destroy
	has_many :users, through: :user_fans
	has_many :event_bands, dependent: :destroy
	has_many :events, through: :event_bands
	has_many :band_genres, dependent: :destroy
	has_many :genres, through: :band_genres
	has_many :tagged_bands, dependent: :destroy
	has_many :posts, through: :tagged_bands
	has_many :youtubes, dependent: :destroy
	has_many :band_managers, dependent: :destroy
	#has_many :managers, through: :band_managers, class_name: 'User'
	belongs_to :user
	accepts_nested_attributes_for :youtubes, allow_destroy: true
	accepts_nested_attributes_for :genres
	validates :name, presence: true, uniqueness: true
	scope :approved, -> { where(approved: true) }
	scope :unapproved, -> { where(approved: false) }
	after_save :approval_notification, if: :approved_changed?
	after_create :make_manager

	attr_reader :genre_tokens


	paginates_per 20

	has_attached_file :avatar, :styles => { :large => "900x900>", :medium => "300x300#", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def self.tokens(query)
  	bands = self.where("name ilike :q or korean_name ilike :q", q: "%#{query}%")
  	if bands.empty?
  		[{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
  	else
  		bands << {id: "<<<#{query}>>>", name: "New: \"#{query}\""}
  	end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1, korean_name: $1).id }
  	tokens.split(',')
  end

	def fans
		self.user_fans.where(band_id: self.id).count
	end 

	def genre_tokens=(tokens)
		self.genre_ids = Genre.ids_from_tokens(tokens)
	end
  
  def upcoming_events
    self.events.where(["date > ? ", Date.yesterday])
  end
	

	def self.search_and_order(search, page_number)
    if search
		where("name LIKE ?", "%#{search.downcase}%").order(
      	name: :asc
	    ).page page_number
    else
		approved.order(name: :asc).page page_number
    end
	end

	def self.admin_search(search, page_number)
		if search
			self.where("name ilike :q or korean_name ilike :q", q: "%#{search}%").order(approved: :asc).page page_number
		else
			order(approved: :asc).page page_number
		end
	end
  
  def self.index_search(query, page_number)
    if query.present?
    	self.approved.where("name ilike :q or korean_name ilike :q", q: "%#{query}%").page page_number
    else
	    approved.page page_number
    end
  end

  def tweets
  	@tweet_url = twitter.gsub(/^[^_]*twitter.com\//, '')
  	twitter_client.user_timeline("#{@tweet_url}").take(1)
    rescue 
  	[]
  end

  def soundcloud_stream
    unless self.soundcloud.blank?
      @track_url = self.soundcloud
      @client = Soundcloud.new(:client_id => 'b8e640fd38bce5816e3e15ca83bc75cc')
      @client.get('/oembed', :url => @track_url ).html_safe
		end
    rescue
		[]
  end

	def make_manager
		unless self.user.blank?
			BandManager.create!(band_id: self.id, user_id: self.user.id, approved: true)
		end
	end

  private

    def approval_notification
		  if self.approved == true && self.user != nil
		    UserMailer.band_approved_email(self).deliver
      end
    end
end
