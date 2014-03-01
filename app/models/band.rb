class Band < ActiveRecord::Base
	has_many :user_fans
	has_many :users, through: :user_fans
end
