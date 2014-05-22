class CitiesController < ApplicationController
	def show
		@city = City.find_by(en_name: params[:en_name])
    @venues = @city.venues.approved.localized
    @hash = Gmaps4rails.build_markers(@venues) do |venue, marker|
	    marker.lat venue.latitude
	    marker.lng venue.longitude
	   # marker.title venue.name
	    marker.infowindow "<a href=\"http://www.doindie.co.kr/venues/#{venue.slug}\">#{venue.name}</a>"
    end
    @cities = City.find_by_ids(City.unique_has_venues)
	end

	def events
		@city = City.find_by(en_name: params[:en_name])
	end

	def index
    @cities = City.all
	  render json: @cities.tokens(params[:q])
	end
end
