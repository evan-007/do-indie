class Genre < ActiveRecord::Base
	validates :name, uniqueness: true
	has_many :band_genres, dependent: :destroy
	has_many :bands, through: :band_genres

  scope :all_with_weight, { 
    select: 'genres.*, COUNT(band_genres.id) as bands_count', 
    joins: 'LEFT JOIN band_genres ON band_genres.genre_id = genres.id', 
    group: 'genres.id'
  }


  def self.tokens(query)
  	genres = self.where("name ilike :q", q: "%#{query}%")
  	if genres.empty?
  		[{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
  	else
  		genres << {id: "<<<#{query}>>>", name: "New: \"#{query}\""}
  	end
  end

  def self.ids_from_tokens(tokens)
  	tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
  	tokens.split(',')
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