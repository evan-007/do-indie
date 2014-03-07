class EventsController < ApplicationController
	before_action :get_event, only: [:show, :edit, :update, :destroy]
	def index
		@events = Event.search_and_order(params[:search], params[:page])
	end

	def show
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.create(event_params)
		if @event.save
			@event.event_bands.create(event_band_params)
			flash[:notice] = "Event Created!"
			redirect_to event_path(@event)
		else
			flash[:notice] = "Event not created!"
			redirect_to new_event_path
		end
	end

	private
	  def get_event
	  	@event = Event.find(params[:id])
	  end

	  def event_params
	  	params.require(:event).permit(:name, :contact, :price, :info, :venue_id, :date)
	  end

	  def event_band_params
	  	params.require(:event_band).permit(:band_id)
	  end
end