class GenresController < ApplicationController
	def show
    @genres = Genre.all
		@genre = Genre.find_by(name: params[:name])
	end
end
