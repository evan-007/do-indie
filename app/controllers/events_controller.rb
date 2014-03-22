class EventsController < ApplicationController
	before_action :get_event, only: [:show, :edit, :update, :destroy]
	def index
		@events = Event.index_search(params[:query], params[:page])
		#events are not paginated! add another view for all events?
	end

	def show
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			flash[:notice] = "Event Created!"
			redirect_to event_path(@event)
		else
			flash[:notice] = "Event not created!"
			redirect_to new_event_path
		end
	end
  
	def edit
	end
  
	def update
		@event.update(event_params)
		if @event.save
			flash[:notice] = "Event updated!"
			redirect_to event_path(@event)
		else
			flash[:notice] = "Event wasn't updated!"
			redirect_to event_edit_path(@event)
		end
	end

	def past
		@events = Event.past_index_search(params[:query], params[:page])
	end

	private
	  def get_event
	  	@event = Event.friendly.find(params[:id])
	  end

	  def event_params
	  	params.require(:event).permit(:name,
		  	:ko_name,
		  	:avatar,
		  	:time,
		  	:facebook,
		  	:ticket,
		  	:door_price,
		  	:ticket_url,
		  	:info_kr, 
	  		:contact, 
	  		:price,
	  		:info,
	  		:info_ko, 
	  		:venue_id, 
	  		:date,
	  		band_ids: []
	  		)
	  end

	  def event_band_params
	  	params.require(:event).permit(event_bands_attributes: [band_ids: []])
	  end
end