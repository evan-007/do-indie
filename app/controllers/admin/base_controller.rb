class Admin::BaseController < ApplicationController
  before_filter :require_admin!
  
  def index
    @last_signups = User.last_signups(10)
    @last_signins = User.last_signins(10)
    @count = User.users_count
    @bands = Band.count
    @venues = Venue.count
    @events = Event.count
    @managers = BandManager.where(approved: false).count
    @venue_managers = VenueManager.where(approved: false).count

  end
end