class Admin::BandsController < Admin::BaseController
  before_action :set_band, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]
  

  def index
    @bands = Band.order(params[:sort]).admin_search(params[:search], params[:page])
  end
  
  def show
    redirect_to edit_admin_band_path(params[:id])
  end
  
  def edit
  end
  
  def update
    @band.update(band_params)
    if @band.valid?
      @band.save
      redirect_to admin_bands_path, notice: "#{@band.name} updated."
    else
      flash[:alert] = "#{@band.name} couldn't be updated."
      render :edit
    end
  end

  def destroy
    if @band.destroy
      flash[:notice] = "Band Deleted"
      redirect_to admin_bands_path
    else
      flash[:notice] = "Couldn't be deleted"
      redirect_to admin_bands_path
    end
  end
  
  
  private 
  
  def set_band
    @band = Band.friendly.find(params[:id])
  rescue
    flash[:alert] = "The band with an id of #{params[:id]} doesn't exist."
    redirect_to admin_bands_path
  end
  
  def band_params
    params.require(:band).permit(:name,
    :korean_name,
    :contact,
    :facebook,
    :myspace,
    :bandcamp,
    :twitter,
    :cafe,
    :itunes,
    :soundcloud,
    :youtube,
    :site,
    :en_bio,
    :label,
    :ko_bio,
    :avatar,
    :approved,
    :genre_tokens,
    genre_ids: [],
    youtubes_attributes: [:link, :_destroy, :id],
    genres_attributes: [:name]
    )
  end
  
end
