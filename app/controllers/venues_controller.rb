class VenuesController < ApplicationController
  before_filter :authenticate_user, only: [:new, :edit, :update, :destroy]
  before_action :get_venue, only: [:show, :edit, :update, :destoy]
  
  def index
    @venues = Venue.all
  end
  
  def show
  end
  
  
  private
  
  def get_venue
    @venue = Venue.find(params[:id])
  end
end
