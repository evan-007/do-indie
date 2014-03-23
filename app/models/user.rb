class User < ActiveRecord::Base
  has_many :user_fans
  has_many :bands, through: :user_fans
  has_many :band_managers
  has_many :managed_bands, :as => :bands, through: :band_managers
  has_many :venue_managers
  has_many :managed_venues, :as => :venues, through: :venue_managers 
  has_many :event_managers
  has_many :managed_events, :as => :events, through: :event_managers
  has_many :bands
  has_many :events
  has_many :venues
  # Use friendly_id on Users
  extend FriendlyId
  friendly_id :friendify, use: :slugged

  def approved_manager?(band_id)
    self.band_managers.where(band_id: band_id).first.approved
  end
  
  def venue_manager?(venue_id)
    self.venue_managers.where(venue_id: venue_id).first.approved
  end
  
  def event_manager?(event_id)
    self.event_managers.where(event_id: event_id).first.approved
  end

  def name_with_email
    "#{self.username}, #{self.email}"
  end
  
  # necessary to override friendly_id reserved words
  def friendify
    if username.downcase == "admin"
      "user-#{username}"
    else
      "#{username}"
    end
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #removed :confirmable, db still setupfor it!
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]
         
  # Pagination
  paginates_per 100
  
  # Validations
  # :username
  validates :username, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /\A[a-zA-Z0-9]*\z/, on: :create, message: "can only contain letters and digits"
  validates :username, length: { in: 4..10 }
  # :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  def self.paged(page_number)
    order(admin: :desc, username: :asc).page page_number
  end
  
  def self.search_and_order(search, page_number)
    if search
      where("username LIKE ?", "%#{search.downcase}%").order(
      admin: :desc, username: :asc
      ).page page_number
    else
      order(admin: :desc, username: :asc).page page_number
    end
  end
  
  def self.text_search(query)
    if query.present?
      where("username @@ :q or email @@ :q", q: query).order(
        admin: :desc, username: :asc)
    else
      #order(admin: :desc, username: :asc)
    end
  end
  
  def self.last_signups(count)
    order(created_at: :desc).limit(count).select("id","username","slug","created_at")
  end
  
  def self.last_signins(count)
    order(last_sign_in_at: 
    :desc).limit(count).select("id","username","slug","last_sign_in_at")
  end
  
  def self.users_count
    where("admin = ? AND locked = ?",false,false).count
  end

  def self.find_for_facebook_oauth(auth)
  where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.first_name+auth.info.last_name   # assuming the user model has a name
    #  user.image = auth.info.image # assuming the user model has an image
  end
end
end
