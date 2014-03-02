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
    old_username = @user.username
    new_params = user_params.dup
    new_params[:username] = new_params[:username].strip
    new_params[:email] = new_params[:email].strip
    
    @user.username = new_params[:username]
    @user.email = new_params[:email]
    @user.password = new_params[:password] if new_params[:password].strip.length > 0
    @user.password_confirmation = new_params[:password_confirmation] if new_params[:password_confirmation].strip.length > 0
    
    if current_user.id != @user.id
      @user.admin = new_params[:admin]=="0" ? false : true
      @user.locked = new_params[:locked]=="0" ? false : true
    end
    
    if @user.valid?
      @user.skip_reconfirmation!
      @user.save
      redirect_to admin_users_path, notice: "#{@user.username} updated."
    else
      flash[:alert] = "#{old_username} couldn't be updated."
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
  
  def user_params
    params.require(:user).permit(
    :username,
    :email,
    :password,
    :password_confirmation,
    :admin,
    :locked
    )
  end
  
end
