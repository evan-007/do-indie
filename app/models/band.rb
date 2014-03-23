class Band < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	has_many :user_fans
	has_many :users, through: :user_fans
	has_many :event_bands
	has_many :events, through: :event_bands
	has_many :band_genres
	has_many :genres, through: :band_genres
	belongs_to :user
	validates :name, presence: true, uniqueness: true
	scope :approved, -> { where(approved: true) }
	scope :unapproved, -> { where(approved: false) }
	after_save :approval_notification, if: :approved_changed?

	paginates_per 50 #fix pagination

	has_attached_file :avatar, :styles => { :large => "900x900>", :medium => "300x300#", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	def fans
		self.user_fans.where(band_id: self.id).count
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
			where("name LIKE ?", "%#{search.downcase}%").order(
				approved: :asc
				).page page_number
		else
			order(approved: :asc).page page_number
		end
	end
  
  def self.index_search(query, page_number)
    if query.present?
      self.approved.fuzzy_search(query).page page_number
    else
      approved.order(approved: :asc).page page_number
    end
  end

  private

    def approval_notification
    	UserMailer.band_approved_email(self).deliver
	end
end
