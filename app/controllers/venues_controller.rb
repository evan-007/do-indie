class VenuesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :get_venue, only: [:show, :edit, :update, :destoy]
  
  def index
    @venues = Venue.search_and_order(params[:search], params[:page])
    @cities = City.all
  end
  
  def show
    @hash = Gmaps4rails.build_markers(@venue) do |venue, marker|
      marker.lat venue.latitude
      marker.lng venue.longitude
    end
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.create(venue_params)
    if @venue.save
      flash[:notice] = "Venue Created!"
      redirect_to venue_path(@venue)
    else
      flash[:notice] = "Not created!"
      redirect_to new_venue_path
    end
  end

  def edit
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
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, :phone, :address, :en_bio, :ko_bio, :facebook, :cafe, :website)
  end
end
