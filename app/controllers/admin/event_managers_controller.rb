class Admin::EventManagersController < Admin::BaseController
  before_action :set_manager, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]
  
  def new
    @manager = EventManager.new
    @users = User.fuzzy_search(params[:query])
  end

  def create
    @manager = EventManager.new(manager_params)
    if @manager.save
      @manager.update(approved: true)
      flash[:notice] = "Successfully created manager!"
      redirect_to admin_event_managers_en_path
    else
      flash[:notice] = "Didn't create the manager!"
      redirect_to new_admin_event_manager_path
    end
  end

  def index
    @managers = EventManager.search_and_order(params[:search], params[:page])
  end
  
  def show
    redirect_to edit_admin_event_manager_path(params[:id])
  end
  
  def edit
  end
  
  def update
    @manager.update(manager_params)
    
    if @manager.valid?
    
      @manager.save
      redirect_to admin_event_managers_en_path, notice: "Updated permissions for #{@manager.user.username}."
    else
      flash[:alert] = "#{@manager.user.username} couldn't be updated."
      render :edit
    end
  end
  
  
  private 
  
  def set_manager
    @manager = EventManager.find(params[:id])
  rescue
    flash[:alert] = "The manager with an id of #{params[:id]} doesn't exist."
  redirect_to admin_event_managers_en
  end
  
  def manager_params
    params.require(:event_manager).permit(:approved, :user_id, :event_id)
  end
  
end
