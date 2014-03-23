class CitiesController < ApplicationController
	def show
		@city = City.find_by(en_name: params[:en_name])
	    @venues = @city.venues.localized
	    @hash = Gmaps4rails.build_markers(@venues) do |venue, marker|
			marker.lat venue.latitude
			marker.lng venue.longitude
	    end
	end
end
