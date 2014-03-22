class Admin::CitiesController < ApplicationController
	before_action :get_city, only: [:edit, :update, :destroy]
	def index
		@cities = City.admin_search(params[:query], params[:page])
	end

	def show
		redirect_to edit_admin_city_path(params[:id])
	end

	def new
		@city = City.new
	end

	def create
		@city = City.new(city_params)
		if @city.save
			flash[:notice] = "Successfully created the city"
			redirect_to admin_cities_path
		else
			flash[:notice] = "Opps, didn't create the city"
			redirect_to admin_cities_path
		end
	end

	def edit
	end

	def update
		if @city.update(city_params)
			flash[:notice] = "Successfully updated the city"
			redirect_to admin_cities_path
		else
			flash[:notice] = "Didn't update the city!"
			redirect_to edit_admin_city_path(@city)
		end
	end

	def destroy
		if @city.destroy
			flash[:notice] = "Boom! City deleted"
			redirect_to admin_cities_path
		else
			flash[:notice] = "Whoops, can't delete that!"
			redirect_to admin_cities_path
		end
	end

	private

	  def city_params
	  	params.require(:city).permit(:en_name, :ko_name)
	  end

	  def get_city
	  	@city = City.find(params[:id])
	  end
end