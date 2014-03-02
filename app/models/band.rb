class Band < ActiveRecord::Base
	has_many :user_fans
	has_many :users, through: :user_fans
	has_many :event_bands
	has_many :events, through: :event_bands
	validates :name, presence: true, uniqueness: true

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	def fans
		self.user_fans.where(band_id: self.id).count
	end 

	paginates_per 100
end
