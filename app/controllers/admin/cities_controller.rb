class Admin::CitiesController < ApplicationController
	def index
		@cities = City.admin_search(params[:query], params[:page])
	end

	def show
		redirect_to edit_admin_city_path(params[:id])
	end

	def edit
		@city = City.find(params[:id])
	end

	def update
		@city = City.find(params[:id])
		if @city.update(city_params)
			flash[:notice] = "Successfully updated the city"
			redirect_to admin_cities_path
		else
			flash[:notice] = "Didn't update the city!"
			redirect_to edit_admin_city_path(@city)
		end
	end

	private

	  def city_params
	  	params.require(:city).permit(:en_name, :ko_name)
	  end
end