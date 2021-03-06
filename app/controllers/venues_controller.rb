class VenuesController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :get_venue, only: [:show, :edit, :update, :destoy]
  before_action :get_cities, only: [:new, :edit]

  def index
    @venues = Venue.index_search(params[:query], params[:page])
    @all_venues = Venue.all
    @cities = City.find_by_ids(City.unique_has_venues)
    respond_to do |format|
      format.html
      format.json { render json: @all_venues.tokens(params[:q]) }
    end
  end

  def show
    if @venue.approved == false
      flash[:notice] = "Sorry, this venue isn't approved yet"
      redirect_to venues_path
    end
    @hash = Gmaps4rails.build_markers(@venue) do |venue, marker|
      marker.lat venue.latitude
      marker.lng venue.longitude
    end
  end

  def map
    @venues = Venue.approved.localized
    @hash = Gmaps4rails.build_markers(@venues) do |venue, marker|
      marker.lat venue.latitude
      marker.lng venue.longitude
      marker.infowindow "<a href=\"http://www.doindie.co.kr/venues/#{venue.slug}\">#{venue.name}</a>"
    end
  end

  def new
    if current_user == nil
      flash[:alert] = t(:non_member_note)
      redirect_to new_user_session_path
    else
      @venue = current_user.venues.build
    end
  end

  def create
    @venue = current_user.venues.build(venue_params)
    if @venue.save
      flash[:notice] = t(:venue_after_submit)
      redirect_to venues_path
    else
      flash[:notice] = "Not created!"
      render :new
    end
  end

  def edit
    unless current_user.admin
      if current_user.venue_managers.where(venue_id: @venue.id).first == nil
        flash[:notice] = "Sorry, you aren't approved to edit this venue"
        redirect_to venues_path
      end
    end
  end

  def update
    if @venue.update(venue_params)
      flash[:notice] = "Venue updated!"
      redirect_to @venue
    else
      flash[:notice] = "Venue not updated!"
      redirect_to edit_venue_path(@venue)
    end
  end


  private

  def get_venue
    @venue = Venue.friendly.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, 
        :korean_name,
        :avatar, :phone, :address,
        :en_bio, :ko_bio, :facebook,
        :twitter, :cafe, :website,
        :photo, :small_map, :email,
        :en_directions, :ko_directions,
        :minimap, :city_id )
  end

  def get_cities
    @cities = City.all
  end
end