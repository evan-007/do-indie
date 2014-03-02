class PagesController < ApplicationController
  layout 'home', only: [:home]
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home

  end
  
  def inside
  	@likes = current_user.user_fans
  end 
    
end
