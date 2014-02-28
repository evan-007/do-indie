class BandsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :get_band, only: [:show, :edit, :update, :destroy]
  
  def index
    @bands = Band.all
  end
  
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
  
  def show
  end
  
  def edit
  end
  
  def update
    if @band.update(band_params)
      flash[:notice] = "Band updated!"
      redirect_to band_path(@band)
    else
      flash[:notice] = "Band not updated"
      redirect_to edit_band_path(@band)
    end
  end
  
  private
  
  def band_params
    params.require(:band).permit(:name, :contact, :facebook, :twitter, :site)
  end
  
  def get_band
    @band = Band.find(params[:id])
  end
  
end
