class VenueManagersController < ApplicationController
	def create
    @manager = current_user.venue_managers.build(venue_id: params[:venue_id])
		if @manager.save
			flash[:notice] = t(:manager_approval)
			redirect_to(:back)
		else
			flash[:notice] = "Uh oh, something's wrong"
			redirect_to(:back)
		end
	end



	def destroy
	end

	private
end