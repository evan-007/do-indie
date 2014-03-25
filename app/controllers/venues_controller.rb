class VenuesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]
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
    unless @venue.twitter == nil
      @tweet_url = @venue.twitter.gsub(/^[^_]*twitter.com\//, '')
    end
  end

  def new
    @venue = current_user.venues.build
  end

  def create
    @venue = current_user.venues.build(venue_params)
    if @venue.save
      @venue.venue_cities.create(city_id: params[:city])
      @city = City.new(en_name: params[:new_city])
      @city.save
      @venue.venue_cities.create(city_id: @city.id)
      flash[:notice] = "Venue Created! Admin will check your submission and email you once it's approved."
      redirect_to venues_path
    else
      flash[:notice] = "Not created!"
      redirect_to new_venue_path
    end
  end

  def edit
    if current_user.venue_managers.where(venue_id: @venue.id).first == nil
      flash[:notice] = "Sorry, you aren't approved to edit this venue"
      redirect_to venues_path
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
    params.require(:venue).permit(:name, :phone, :address,
     :en_bio, :ko_bio, :facebook, :cafe, :website,
     :photo, :small_map)
  end

  def get_cities
    @cities = City.all
  end
end
