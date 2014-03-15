class CitiesController < ApplicationController
	def show
		@city = City.find_by(en_name: params[:en_name])
	end
end
