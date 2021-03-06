class Admin::BandManagersController < Admin::BaseController
  before_action :set_manager, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]

  def new
    @manager = BandManager.new
    @users = User.text_search(params[:query])
  end

  def create
    @manager = BandManager.new(band_id: params[:band_id], user_id: params[:user_id])
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
      @manager.save
      redirect_to admin_band_managers_en_path, notice: "Updated permissions for #{@manager.user.username}."
    else
      flash[:alert] = "#{@manager.user.username} couldn't be updated."
      render :edit
    end
  end

  def destroy
    if @manager.destroy
      flash[:notice] = "Deleted!"
      redirect_to admin_band_managers_en_path
    else
      flash[:notice] = "Couldn't delete the manager"
      redirect_to edit_admin_band_managers_en_path
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
