class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]
  

  def index
    @events = Event.admin_search(params[:search], params[:page])
  end
  
  def show
    redirect_to edit_admin_event_path(params[:id])
  end
  
  def edit
  end
  
  def update
    @event.update(event_params)

    # if current_event.id != @event.id
    #   @event.admin = new_params[:admin]=="0" ? false : true
    #   @event.locked = new_params[:locked]=="0" ? false : true
    # end
    
    if @event.valid?
     # @event.skip_reconfirmation! only for users model
      @event.save
      redirect_to admin_events_path, notice: "#{@event.name} updated."
    else
      flash[:alert] = "#{old_name} couldn't be updated."
      render :edit
    end
  end

  def data
    if params[:start]
      @start = Date.parse("#{params[:start]['day']}-#{params[:start]['month']}-#{params[:start]['year']}")   
      @end = Date.parse("#{params[:end]['day']}-#{params[:end]['month']}-#{params[:end]['year']}")
    end
    @events = Event.search_by_date(@start, @end)
    @my_date = Date.today
    @end_date = Date.tomorrow
  end
  
  
  private 
  
  def set_event
    @event = Event.friendly.find(params[:id])
  rescue
    flash[:alert] = "The event with an id of #{params[:id]} doesn't exist."
    redirect_to admin_events_path
  end
  
  def event_params
    params.require(:event).permit(:name, :contact, :info, :price, :date, :time, :venue_id, :approved)
  end
  
end
