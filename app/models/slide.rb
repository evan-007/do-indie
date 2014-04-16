class Slide < ActiveRecord::Base
	belongs_to :post
	scope :active_slides, -> { where(active: true) }
	has_attached_file :image, :styles => { :large => "900x900>", :medium => "300x300#", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png", 
						:s3_credentials => S3_CREDENTIALS
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	paginates_per 50
end
