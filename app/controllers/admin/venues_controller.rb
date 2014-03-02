class Admin::VenuesController < Admin::BaseController
  before_action :set_venue, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]
  

  def index
    @venues = Venue.search_and_order(params[:search], params[:page])
  end
  
  def show
    redirect_to edit_admin_venue_path(params[:id])
  end
  
  def edit
  end
  
  def update
    old_name = @venue.name
    new_params = venue_params.dup
    new_params[:name] = new_params[:name].strip
    new_params[:phone] = new_params[:phone].strip
    new_params[:address] = new_params[:address].strip
    new_params[:misc] = new_params[:misc].strip
    new_params[:facebook] = new_params[:facebook].strip
    new_params[:cafe] = new_params[:cafe].strip
    new_params[:website] = new_params[:website].strip

    
    @venue.name = new_params[:name]
    @venue.phone = new_params[:phone]
    @venue.address = new_params[:address]
    @venue.misc = new_params[:misc]
    @venue.facebook = new_params[:facebook]
    @venue.cafe = new_params[:cafe]
    @venue.website = new_params[:website]

    
    # if current_user.id != @venue.id
    #   @user.admin = new_params[:admin]=="0" ? false : true
    #   @user.locked = new_params[:locked]=="0" ? false : true
    # end
    
    if @venue.valid?
      @venue.save
      redirect_to admin_venues_path, notice: "#{@venue.name} updated."
    else
      flash[:alert] = "#{old_name} couldn't be updated."
      render :edit
    end
  end
  
  
  private 
  
  def set_venue
    @venue = Venue.find(params[:id])
  rescue
    flash[:alert] = "The venue with an id of #{params[:id]} doesn't exist."
    redirect_to admin_venues_path
  end
  
  def venue_params
    params.require(:venue).permit(
    :name,
    :phone,
    :address,
    :misc,
    :facebook,
    :cafe,
    :website
    )
  end
  
end
