class PagesController < ApplicationController
  layout 'home', only: [:home]
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    @slides = Slide.active_slides
    @events = Event.upcoming
    @posts = Post.published
  end
  
  def inside
  	@likes = current_user.user_fans
    @events = current_user
  	@managed_bands = current_user.band_managers.approved
    @managed_venues = current_user.venue_managers.approved
    @managed_events = current_user.event_managers.approved
  end 

  def photo
    @page = Page.first
  end

  def winner
    @page = Page.last
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update(page_params)
      flash[:notice] = "Updated the page"
      redirect_to photo_path
    else
      flash[:notice] = "Couldn't update the page"
      redirect_to photo_path
    end
  end

  def signup
    User.email_signup(current_user)
    current_user.update(mailing_list: true)
    flash[:notice] = "Thanks for signing up, check your email later!"
    redirect_to inside_path
  end

  def jplayer
    render layout: "blank"
  end
  
  private
    def page_params
      params.require(:page).permit(:body)
    end
end
