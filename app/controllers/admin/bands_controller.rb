class Admin::BandsController < Admin::BaseController
  before_action :set_band, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]
  

  def index
    @bands = Band.order(name: :desc)
  end
  
  def show
    redirect_to edit_admin_band_path(params[:id])
  end
  
  def edit
  end
  
  def update
    old_name = @band.name
    new_params = band_params.dup
    new_params[:name] = new_params[:name].strip
    new_params[:korean_name] = new_params[:korean_name].strip
    
    @band.name = new_params[:name]
    @band.korean_name = new_params[:korean_name]
    
    # if current_user.id != @band.id
    #   @user.admin = new_params[:admin]=="0" ? false : true
    #   @user.locked = new_params[:locked]=="0" ? false : true
    # end
    
    if @band.valid?
      @band.save
      redirect_to admin_bands_path, notice: "#{@band.name} updated."
    else
      flash[:alert] = "#{old_name} couldn't be updated."
      render :edit
    end
  end
  
  
  private 
  
  def set_band
    @band = Band.find(params[:id])
  rescue
    flash[:alert] = "The band with an id of #{params[:id]} doesn't exist."
    redirect_to admin_bands_path
  end
  
  def band_params
    params.require(:band).permit(
    :name,
    :korean_name,
    :contact,
    :facebook,
    :twitter,
    :site
    )
  end
  
end
