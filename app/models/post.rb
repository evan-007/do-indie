class Post < ActiveRecord::Base
	has_one :slide
	scope :published, -> { where(published: true) }
	extend FriendlyId
	friendly_id :title, use: :slugged
	accepts_nested_attributes_for :slide
end
