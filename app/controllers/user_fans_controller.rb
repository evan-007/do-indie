class UserFansController < ApplicationController
	before_action :get_user_fans, only: [:destroy]
	def create
		@user_fans = current_user.user_fans.build(band_id: params[:band_id])
		@band = Band.find(params[:band_id])
		if @user_fans.save
			flash[:notice] = "You're a fan of #{@band.name}!"
			redirect_to(:back)
		else
			flash[:notice] = "You can't do that!"
		end
	end

	def destroy
		@user_fan = current_user.user_fans.find_by(band_id: (params[:id]))
		@band = @user_fan.band.name
		if @user_fan.destroy
			flash[:notice] = "You're no longer a fan of #{@band} :("
			redirect_to(:back)
		else
			flash[:notice] = "You can't do that"
			redirect_to(:back)
		end
	end

	private
	  # def user_fan_params
	  # 	params.require(:user_fan).permit(:band_id)
	  # end

	  def get_user_fans
      @user_fan = current_user.user_fans.where(band_id: params[:band_id]).first
	  end

end
