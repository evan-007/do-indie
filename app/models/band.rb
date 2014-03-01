class Band < ActiveRecord::Base
	has_many :user_fans
	has_many :users, through: :user_fans
	has_many :event_bands
	has_many :events, through: :event_bands
	validates :name, presence: true, uniqueness: true

	def fans
		self.user_fans.where(band_id: self.id).count
	end 
end
