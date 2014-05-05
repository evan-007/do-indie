class GenresController < ApplicationController

	def index
		@genres = Genre.all
		respond_to do |format|
			format.html
			format.json { render json: @genres.tokens(params[:q]) }
		end
	end

	def show
    @genres = Genre.all
		@genre = Genre.find_by(name: params[:name])
	end
end
