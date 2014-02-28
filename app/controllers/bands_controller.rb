class BandsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :destroy]
  
  def new
    @band = Band.new
  end
  
  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:notice] = "Band created!"
      redirect_to band_path(@band)
    else
      flash[:notice] = "Band not created!"
      render :new
    end
  end
  private
  
  def band_params
    params.require(:band).permit(:name, :contact, :facebook, :twitter, :site)
  end
  
end
