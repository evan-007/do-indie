class UserFansController < ApplicationController
	def create
		@user_fans = current_user.user_fans.build(band_id: params[:band_id])
		if @user_fans.save
			flash[:notice] = "You're a fan!"
			redirect_to bands_path
		else
			flash[:notice] = "You can't do that!"
		end
	end

	def destroy
	end

	private
	  # def user_fan_params
	  # 	params.require(:user_fan).permit(:band_id)
	  # end

end
