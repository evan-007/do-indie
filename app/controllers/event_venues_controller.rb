class EventVenuesController < ApplicationController
	def create
		@eventvenue = EventVenue.new(venue_id: params[:venue_id], event_id: params[:event_id])
		if @eventvenue.save
			flash[:notice] = "Venue Added!"
			redirect_to events_path
		else
			flash[:notice] = "Not added!"
			redirect_to events_path
		end
	end

	def destroy
	end
end
