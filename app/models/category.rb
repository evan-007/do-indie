class Category < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	has_many :post_categories
	has_many :posts, through: :post_categories
  validates :name, presence: true

  def self.tokens(query)
  	categories = self.where("name ilike :q", q: "%#{query}%")
  	if categories.empty?
  		[{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
  	else
  		categories << {id: "<<<#{query}>>>", name: "New: \"#{query}\""}
  	end
  end

  def self.ids_from_tokens(tokens)
  	tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
  	tokens.split(',')
  end
end
