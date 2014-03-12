class EventManagersController < ApplicationController
	def create
    @manager = current_user.event_managers.build(event_id: params[:event_id])
		if @manager.save
			flash[:notice] = "Thanks, admin will check and approve your request shortly."
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
