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
    redirect_to edit_admin_band_manager_path(params[:id])
  end
  
  def edit
  end
  
  def update
    @manager.update(event_params)

    # if current_event.id != @event.id
    #   @event.admin = new_params[:admin]=="0" ? false : true
    #   @event.locked = new_params[:locked]=="0" ? false : true
    # end
    
    if @manager.valid?
     # @event.skip_reconfirmation! only for users model
      @manager.save
      redirect_to admin_band_managers_en_path, notice: "Updated permissions for #{@manager.user.username}."
    else
      flash[:alert] = "#{@manager.user.username} couldn't be updated."
      render :edit
    end
  end
  
  
  private 
  
  def set_manager
    @manager = BandManager.find(params[:id])
  rescue
    flash[:alert] = "The manager with an id of #{params[:id]} doesn't exist."
    redirect_to admin_band_managers_en
  end
  
  def event_params
    params.require(:band_manager).permit(:approved)
  end
  
end
