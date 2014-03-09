class BandManagersController < ApplicationController
	def create
		@manager = current_user.band_managers.build(band_id: params[:band_id])
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

	  # def band_manager_params
	  # 	params.require(:band_manager).permit(:band_id)
	  # end
end
