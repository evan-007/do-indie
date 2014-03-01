class Band < ActiveRecord::Base
	has_many :user_fans
	has_many :users, through: :user_fans

	def fans
		self.user_fans.where(band_id: self.id).count
	end 
end
