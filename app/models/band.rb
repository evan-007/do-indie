class Band < ActiveRecord::Base
	has_many :user_fans
	has_many :users, through: :user_fans
	has_many :event_bands
	has_many :events, through: :event_bands
	# validates :name, presence: true, uniqueness: true

	paginates_per 50 #fix pagination

	has_attached_file :avatar, :styles => { :large => "900x900>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	def fans
		self.user_fans.where(band_id: self.id).count
	end 


	

	def self.search_and_order(search, page_number)
	    if search
			where("name LIKE ?", "%#{search.downcase}%").order(
	      	name: :asc
		    ).page page_number
	    else
			order(name: :asc).page page_number
	    end
	end
end
