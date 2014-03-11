class PagesController < ApplicationController
  layout 'home', only: [:home]
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home

  end
  
  def inside
  	@likes = current_user.user_fans
  	@managed_bands = current_user.band_managers.approved
    @managed_venues = current_user.venue_managers.approved
  end 
    
end
