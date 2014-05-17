class VenueFansController < ApplicationController  
  def create
    if current_user.venue_fans.where(venue_id: params[:id]).exists?
      flash[:notice] = "You can only like a band once!"
      redirect_to venues_path
    else
      @fan = current_user.venue_fans.build(venue_id: (params[:id]))
      if @fan.save
        flash[:notice] = t(:new_fan, thing: @fan.venue.name)
        redirect_to(:back)
      else
        flash[:notice] = "You can't do that, sorry"
        redirect_to(:back)
      end
    end
  end
  
  def destroy
    @fan = current_user.venue_fans.where(venue_id: params[:id]).first
    if @fan.destroy
      flash[:notice]= t(:not_fan, thing: @fan.venue.name)
      redirect_to(:back)
    else
      flash[:notice] = "You can't do that!"
      redirect_to(:back)
    end
  end
    
  private
    def liked_venue_params
      params.require(:venue_fan).permit(:venue_id)
    end
end