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
    @venue.update(venue_params)
    
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
    :en_bio,
    :ko_bio,
    :facebook,
    :cafe,
    :website
    )
  end

end