class User < ActiveRecord::Base
  #validations

  validates :username, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /\A[a-zA-Z0-9\s\p{Hangul}]*\z/, on: :create, message: I18n.t('activerecord.errors.models.user.attributes.username.length')
  #message: "can only contain letters and digits"
  validates :username, length: { in: 3..20 }
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  #associations
  has_many :user_fans
  has_many :bands, through: :user_fans
  has_many :band_managers
  has_many :managed_bands, through: :band_managers
  has_many :venue_managers
  has_many :managed_venues, through: :venue_managers 
  has_many :event_managers
  has_many :managed_events, through: :event_managers
  has_many :bands
  has_many :events
  has_many :venues
  has_many :venue_fans, dependent: :destroy
  has_many :liked_venues, through: :venue_fans, source: :venue

  extend FriendlyId
  friendly_id :friendify, use: :slugged

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter]
         
  paginates_per 100
  
  def liked_band_events
    event_ids = []
    self.user_fans.each do |f|
      f.band.events.upcoming.each do |e|
        event_ids << e
      end
    end
    return event_ids
  end

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
  
  def friendify
    if username.downcase == "admin"
      "user-#{username}"
    else
      "#{username}"
    end
  end
  
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

  def self.admin_search_and_order(search, page_number)
    if search
      self.fuzzy_search(search).order(admin: :desc,
       username: :asc).page page_number
    else
      order(admin: :desc, username: :asc).page page_number
    end
  end
  
  def self.text_search(query)
    if query.present?
      where("username @@ :q or email @@ :q", q: query).order(
        admin: :desc, username: :asc)
    else
      order(admin: :desc, username: :asc)
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
      user.username = "#{auth.info.first_name} #{auth.info.last_name}"
    end
  end
  
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@twitter.com").first
      if registered_user
        return registered_user
      else

        user = User.create(username:auth.info.nickname,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.uid+"@twitter.com",
                            password:Devise.friendly_token[0,20],
                          )
      end

    end
  end

  def self.email_signup(user)
    @gb = Gibbon::API.new
    @gb.lists.subscribe({:id => '40a37c22ca', :email => {:email => "#{user.email}"},
      :merge_vars => {:FNAME => "#{user.username}", :LNAME => nil}, 
      :double_optin => false})
  end
end
