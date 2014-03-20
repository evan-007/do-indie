class Admin::BandManagersController < Admin::BaseController
  before_action :set_manager, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]

  def new
    @manager = BandManager.new
  end

  def create
    @manager = BandManager.new(manager_params)
    if @manager.save
      @manager.update(approved: true)
      flash[:notice] = "Successfully created manager!"
      redirect_to admin_band_managers_en_path
    else
      flash[:notice] = "Didn't create the manager!"
      redirect_to new_admin_band_manager_path
    end
  end
  

  def index
    @managers = BandManager.search_and_order(params[:search], params[:page])
  end
  
  def show
    redirect_to edit_admin_band_manager_path(params[:id])
  end
  
  def edit
  end
  
  def update
    @manager.update(manager_params)
    
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
  
  def manager_params
    params.require(:band_manager).permit(:approved, :user_id, :band_id)
  end
  
end
