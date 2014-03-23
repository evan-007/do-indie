class Admin::GenresController < ApplicationController
	before_action :find_genre, only: [:show, :edit, :update, :destroy]

	def new
		@genre = Genre.new
	end

	def create
		@genre = Genre.new(genre_params)
		if @genre.save
			flash[:notice] = "Genre created"
			redirect_to admin_genres_path
		else
			flash[:notice] = "Genre wasn't created!"
			redirect_to new_admin_genre_path
		end
	end

	def show
		redirect_to edit_admin_genre_path(params[:id])
	end

	def index
		@genres = Genre.search_and_order(params[:search], params[:page])
	end

	def edit
	end

	def update
		if @genre.update(genre_params)
			flash[:notice] = "Successfully updated genre"
			redirect_to admin_genres_path
		else
			flash[:notice] = "Genre wasn't updated!"
			redirect_to edit_admin_genre_path(@genre)
		end
	end

	def destroy
		if @genre.destroy
			flash[:notice] = "Boom! Genre destroyed!"
			redirect_to admin_genres_path
		else
			flash[:notice] = "Genre wasn't deleted!"
			redirect_to edit_admin_genre_path(@genre)
		end
	end

	private

	  def find_genre
	  	@genre = Genre.find(params[:id])
	  end

	  def genre_params
	  	params.require(:genre).permit(:name)
	  end
end
