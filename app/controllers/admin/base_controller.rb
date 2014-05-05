class Admin::BaseController < ApplicationController
  before_filter :require_admin!
  
  def index
    @last_signups = User.last_signups(10)
    @last_signins = User.last_signins(10)
    @count = User.users_count
    @bands = Band.unapproved.count
    @venues = Venue.unapproved.count
    @events = Event.unapproved.count
    @managers = BandManager.where(approved: false).count
    @venue_managers = VenueManager.where(approved: false).count
    @event_managers = EventManager.where(approved: false).count
    @cities = City.where(ko_name: nil).count
    @posts = Post.unpublished.count
  end
end