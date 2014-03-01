class EventBandsController < ApplicationController
	def create
		@event_band = EventBand.new(event_id: (params[:event_id]), band_id: (params[:band_id]))
		if @event_band.save
			flash[:notice] = "Band added!"
			redirect_to events_path
		else
			flash[:notice] = "Not added!"
			redirect_to events_path
		end
	end

	def destroy
	end

end
