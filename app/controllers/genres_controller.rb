class GenresController < ApplicationController
	def show
		@genre = Genre.find_by(name: params[:name])
	end
end
