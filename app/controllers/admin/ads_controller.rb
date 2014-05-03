class Admin::AdsController < ApplicationController
	before_action :set_ad, only: [:edit, :update, :destroy]

	def index
		@ads = Ad.all
	end

	def new
		@ad = Ad.new
	end

	def create
		@ad = Ad.new(ad_params)
		if @ad.save
			flash[:notice] = "Ad created"
			redirect_to admin_ads_path
		else
			flash[:notice] = "Ad not created"
			render :new
		end
	end

	def edit
	end

	def update
		if @ad.update(ad_params)
			flash[:notice] = "Ad updated"
			redirect_to admin_ads_path
		else
			flash[:notice] = "Ad not updated"
			redirect_to edit_admin_ad_path(@ad)
		end
	end

	def destroy
		if @ad.destroy
			flash[:notice] = "Ad deleted"
			redirect_to admin_ads_path
		else
			flash[:notice] = "Ad was not deleted!"
			redirect_to admin_ads_path
		end
	end


	private
	  def ad_params
	  	params.require(:ad).permit(:link, :image)
	  end

	  def set_ad
	  	@ad = Ad.find(params[:id])
	  end
end
