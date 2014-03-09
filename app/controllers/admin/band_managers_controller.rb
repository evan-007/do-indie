class Admin::BandManagersController < Admin::BaseController
  before_action :set_manager, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]
  

  def index
    @managers = BandManager.search_and_order(params[:search], params[:page])
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
  
  
  private 
  
  def set_event
    @event = Event.find(params[:id])
  rescue
    flash[:alert] = "The event with an id of #{params[:id]} doesn't exist."
    redirect_to admin_events_path
  end
  
  def event_params
    params.require(:event).permit(:name, :contact, :info, :price, :date, :time, :venue_id)
  end
  
end
