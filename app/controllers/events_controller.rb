class EventsController < ApplicationController
	before_action :get_event, only: [:show, :edit, :update, :destroy]
	def index
		@events = Event.all
	end

	def show
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.create(event_params)
		if @event.save
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
	  	params.require(:event).permit(:name, :contact, :price, :info, :venue_id)
	  end

	  def event_venue_params
	  	params.require(:event_venue).permit(:band_id)
	  end
end