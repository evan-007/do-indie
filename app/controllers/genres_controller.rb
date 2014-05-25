class GenresController < ApplicationController

	def index
		@genres = Genre.all_with_weight
		@genres_json = Genre.all
		respond_to do |format|
			format.html
			format.json { render json: @genres_json.tokens(params[:q]) }
		end
	end

	def show
    	@genres = Genre.all_with_weight
		@genre = Genre.find_by(name: params[:name])
	end
end
