class Admin::VenueManagersController < Admin::BaseController
  before_action :set_manager, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]
  
  def new
    @manager = VenueManager.new
    @users = User.fuzzy_search(params[:query])
  end

  def create
    @manager = VenueManager.new(venue_id: params[:venue_id], user_id: params[:user_id])
    if @manager.save
      @manager.update(approved: true)
      flash[:notice] = "Successfully created manager!"
      redirect_to admin_venue_managers_en_path
    else
      flash[:notice] = "Didn't create the manager!"
      redirect_to new_admin_venue_manager_path
    end
  end

  def index
    @managers = VenueManager.search_and_order(params[:search], params[:page])
  end
  
  def show
    redirect_to edit_admin_venue_manager_path(params[:id])
  end
  
  def edit
  end
  
  def update
    @manager.update(manager_params)

    # if current_event.id != @event.id
    #   @event.admin = new_params[:admin]=="0" ? false : true
    #   @event.locked = new_params[:locked]=="0" ? false : true
    # end
    
    if @manager.valid?
     # @event.skip_reconfirmation! only for users model
      @manager.save
      redirect_to admin_venue_managers_en_path, notice: "Updated permissions for #{@manager.user.username}."
    else
      flash[:alert] = "#{@manager.user.username} couldn't be updated."
      render :edit
    end
  end
  
  
  private 
  
  def set_manager
    @manager = VenueManager.find(params[:id])
  rescue
    flash[:alert] = "The manager with an id of #{params[:id]} doesn't exist."
    redirect_to admin_venue_managers_en
  end
  
  def manager_params
    params.require(:venue_manager).permit(:approved, :venue_id, :user_id)
  end
  
end
