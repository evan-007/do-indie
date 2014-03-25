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
    @managed_events = current_user.event_managers.approved
  end 

  def photo
  end

  def signup
    User.email_signup(current_user)
    current_user.update(mailing_list: true)
    flash[:notice] = "Thanks for signing up, check your email later!"
    redirect_to inside_path
  end
end
