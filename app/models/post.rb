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
	
	extend FriendlyId
	friendly_id :title, use: :slugged
	accepts_nested_attributes_for :slide, allow_destroy: true
	acts_as_taggable
end
