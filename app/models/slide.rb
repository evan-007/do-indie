class Slide < ActiveRecord::Base
	belongs_to :post
	scope :active_slides, -> { where(active: true) }
	has_attached_file :image, :styles => { :large => "900x900>", :medium => "300x300#", :thumb => "100x100>" }
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	paginates_per 50
	validates :en_title, :ko_title, :en_description, :ko_description, :anchor, :link, presence: true
end
