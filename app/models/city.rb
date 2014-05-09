class City < ActiveRecord::Base
	validates :en_name, uniqueness: true, presence: true
	has_many :venues, dependent: :destroy
	has_many :events, dependent: :destroy

	def self.admin_search(search, page_number)
		if search
			where("name LIKE ?", "%#{search.downcase}%").order(
				ko_name: :desc
				).page page_number
		else
			order(ko_name: :desc).page page_number
		end
	end

  def self.has_upcoming_events
    joins(:events).where("date > ?" > Date.today.to_s)
  end
  
  def self.has_venues
    joins(:venues).where.not(venues: {city_id: nil})
  end
  
  def self.unique_has_venues
    ids = self.has_venues.map { |city| city.id}
    return ids.uniq
  end
  
  def self.find_by_ids(ids)
    list = []
    ids.each do |id|
      list << self.find(id)
    end
    return list
  end

  def self.tokens(query)
    cities = where("en_name ilike :q or ko_name ilike :q", q: "%#{query}%")
    if cities.empty?
  		[{id: "<<<#{query}>>>", en_name: "New: \"#{query}\""}]
  	else
      cities << {id: "<<<#{query}>>>", en_name: "New: \"#{query}\""}
  	end
  end
  
  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(en_name: $1).id }
  	tokens.split(',')
    return tokens
  end
end
