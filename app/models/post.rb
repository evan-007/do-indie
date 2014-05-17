class Post < ActiveRecord::Base
	has_many :post_categories
	has_many :categories, through: :post_categories
	has_many :post_tags
	has_many :tags, through: :post_tags
	has_many :tagged_bands
	has_many :bands, through: :tagged_bands

	paginates_per 20
	accepts_nested_attributes_for :categories

	scope :published, -> { where(published: true) }
	scope :unpublished, -> { where(published: false) }

	has_attached_file :image, :styles => { :large => "900x900>", :medium => "300x300#", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	attr_reader :category_tokens
	
	extend FriendlyId
	friendly_id :title, use: :slugged
	acts_as_taggable

	def category_tokens=(tokens)
		self.category_ids = Category.ids_from_tokens(tokens)
	end

	def self.admin_search(search, page_number)
		if search
			self.where("title ilike :q or ko_title ilike :q", q: "%#{search}%").order(created_at: :desc).page page_number
		else
			order(created_at: :desc).page page_number
		end
	end

  def self.index_search(query, page_number)
    if query.present?
    	self.approved.where("name ilike :q or korean_name ilike :q", q: "%#{query}%").page page_number
    else
	    approved.page page_number
    end
  end
end
