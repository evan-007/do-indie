class Post < ActiveRecord::Base
	has_many :post_categories
	has_many :categories, through: :post_categories
	has_many :post_tags
	has_many :tags, through: :post_tags
	has_many :tagged_bands
	has_many :bands, through: :tagged_bands
	has_one :slide

	scope :published, -> { where(published: true) }
	scope :unpublished, -> { where(published: false) }

	has_attached_file :image, :styles => { :large => "900x900>", :medium => "300x300#", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	
	extend FriendlyId
	friendly_id :title, use: :slugged
	accepts_nested_attributes_for :slide, allow_destroy: true
	acts_as_taggable

	def self.admin_search(search, page_number)
		if search
			self.where("name ilike :q or korean_name ilike :q", q: "%#{search}%").order(created_at: :desc).page page_number
		else
			order(created_at: :desc).page page_number
		end
	end
end
