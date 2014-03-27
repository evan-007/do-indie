class CitiesController < ApplicationController
	def show
		@city = City.find_by(en_name: params[:en_name])
    @venues = @city.venues.approved.localized
	    @hash = Gmaps4rails.build_markers(@venues) do |venue, marker|
        marker.lat venue.latitude
        marker.lng venue.longitude
       # marker.title venue.name
        marker.infowindow "<a href=\"http://hidden-dawn-9617.herokuapp.com/venues/#{venue.slug}\">#{venue.name}</a>"
	    end
	end
end
