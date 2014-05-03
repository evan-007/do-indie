class EventsController < ApplicationController
	before_filter :authenticate_user!, only: [ :edit, :update, :destroy]
	before_action :get_event, only: [:show, :edit, :update, :destroy]

	def index
		@events = Event.index_search(params[:query], params[:page])
	end

	def show
    if @event.approved == false
      flash[:notice] = "Sorry, this event isn't approved yet"
      redirect_to events_path
    end
	end

	def new
		if current_user == nil
			flash[:alert] = t(:event_new_login)
			redirect_to new_user_session_path
		else
			@event = current_user.events.build
		end
	end

	def create
		@event = current_user.events.build(event_params)
		if @event.save
			flash[:notice] = t(:event_submission_note)
			redirect_to events_path
		else
			flash[:notice] = "Event not created!"
			redirect_to new_event_path
		end
	end
  
	def edit
    unless current_user.admin
      if current_user.event_managers.where(event_id: @event.id).first == nil
        flash[:notice] = "Sorry, you aren't approved to edit this event"
        redirect_to events_path
      end
    end
	end
  
	def update		
		if @event.update(event_params)
			flash[:notice] = "Event updated!"
			redirect_to event_path(@event)
		else
			flash[:warning] = "Event wasn't updated!"			
			redirect_to edit_event_path(@event)
		end
	end

	def past
		@events = Event.past_index_search(params[:query], params[:page])
	end

	def destroy
		if @event.destroy
			flash[:notice] = "Event deleted!"
			redirect_to events_path
		else
			flash[:notice] = "Event wasn't deleted!"
			redirect_to event_edit_path(@event)
		end
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
	  		:band_tokens,
        :venue_tokens,
        :city_id,
	  		band_ids: [],
	  		bands_attributes: [:name],
	  		venue_attributes: [:name, :city]
	  		)
	  end

	  def event_band_params
	  	params.require(:event).permit(event_bands_attributes: [band_ids: []])
	  end
end