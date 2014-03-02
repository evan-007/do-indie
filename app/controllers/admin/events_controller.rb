class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]
  

  def index
    @events = Event.search_and_order(params[:search], params[:page])
  end
  
  def show
    redirect_to edit_admin_event_path(params[:id])
  end
  
  def edit
  end
  
  def update
    old_eventname = @event.name
    new_params = event_params.dup
    new_params[:name] = new_params[:name].strip
    new_params[:contact] = new_params[:contact].strip
    new_params[:info] = new_params[:info].strip
    new_params[:price] = new_params[:price].strip
    new_params[:date] = new_params[:date].strip
    new_params[:time] = new_params[:time].strip
    new_params[:venue_id] = new_params[:venue_id].strip
    
    @event.name = new_params[:name]
    @event.contact = new_params[:contact]
    @event.info = new_params[:info]
    @event.price = new_params[:price]
    @event.date = new_params[:date]
    @event.time = new_params[:time]
    @event.venue_id = new_params[:venue_id]

    # if current_event.id != @event.id
    #   @event.admin = new_params[:admin]=="0" ? false : true
    #   @event.locked = new_params[:locked]=="0" ? false : true
    # end
    
    if @event.valid?
      @event.skip_reconfirmation!
      @event.save
      redirect_to admin_events_path, notice: "#{@event.name} updated."
    else
      flash[:alert] = "#{old_name} couldn't be updated."
      render :edit
    end
  end
  
  
  private 
  
  def set_event
    @event = Event.find(params[:id])
  rescue
    flash[:alert] = "The event with an id of #{params[:id]} doesn't exist."
    redirect_to admin_events_path
  end
  
  def event_params
    params.require(:event).permit(
    :name,
    :contact,
    :info,
    :price,
    :date,
    :time,
    :venue_id
    )
  end
  
end
