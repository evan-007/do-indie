class VenuesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :get_venue, only: [:show, :edit, :update, :destoy]
  
  def index
    @venues = Venue.all
  end
  
  def show
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
  
  
  private
  
  def get_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, :phone, :address, :misc, :facebook, :cafe, :website)
  end
end
