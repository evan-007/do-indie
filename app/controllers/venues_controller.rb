class VenuesController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :get_venue, only: [:show, :edit, :update, :destoy]
  before_action :get_cities, only: [:new, :edit]

  def index
    @venues = Venue.index_search(params[:query], params[:page])
    @cities = City.all
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
      marker.infowindow "<a href=\"http://hidden-dawn-9617.herokuapp.com/venues/#{venue.slug}\">#{venue.name}</a>"
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
    #refactor to use nested params!
    @venue = current_user.venues.build(venue_params)
    if @venue.save
      @venue.venue_cities.create(city_id: params[:city])
      @city = City.new(en_name: params[:new_city])
      @city.save
      @venue.venue_cities.create(city_id: @city.id)
      flash[:notice] = t(:venue_after_submit)
      redirect_to venues_path
    else
      flash[:notice] = "Not created!"
      redirect_to new_venue_path
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
      @venue.venue_cities.create(city_id: params[:city])
      @city = City.new(en_name: params[:new_city])
      @city.save
      @venue.venue_cities.create(city_id: @city.id)
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
        :ko_name,
        :avatar, :phone, :address,
        :en_bio, :ko_bio, :facebook,
        :twitter, :cafe, :website,
        :photo, :small_map, :email,
        :en_directions, :ko_directions,
        :minimap )
  end

  def get_cities
    @cities = City.all
  end
end