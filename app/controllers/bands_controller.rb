class BandsController < ApplicationController
  before_filter :authenticate_user!, only: [ :edit, :update, :destroy]
  before_action :find_friendly, only: [:show, :edit, :update, :destroy]
  before_action :all_genres, only: [:new, :edit]
  before_action :soundcloud, only: [:show]
  
  def index
    @bands = Band.index_search(params[:query], params[:page])
      #search_and_order(params[:search], params[:page])
    @genres = Genre.all
  end
  
  def new
    if current_user == nil
      flash[:alert] = t(:member_band_note)
      redirect_to new_user_session_path
    else
      @band = current_user.bands.build
      4.times { @band.youtubes.build }
    end
  end
  
  def create
    @band = current_user.bands.build(band_params)
    if @band.save
      @genre = Genre.new(name: params[:new_genre])
      @genre.save
      @band.band_genres.create(genre_id: @genre.id)
      @band.band_genres.create(genre_id: params[:genre])
      flash[:notice] = t(:band_after_submission)
      redirect_to bands_path
    else
      flash[:notice] = "Band not created!"
      render :new
    end
  end
  
  def show
    if @band.approved == false
      flash[:notice] = "Sorry, this band hasn't been approved by Admin yet"
      redirect_to bands_path
    end
    unless @band.soundcloud.blank?
      @track_url = @band.soundcloud
      @embed_info = @client.get('/oembed', :url => @track_url )
    end
    # unless @band.twitter == nil
    #   @tweet_url = @band.twitter.gsub(/^[^_]*twitter.com\//, '')
    #   @tweets = twitter_client.user_timeline("#{@tweet_url}").take(3)
    # end
  end
  
  def edit
    unless current_user.admin
      if current_user.band_managers.where(band_id: @band.id).first == nil
        flash[:notice] = "Sorry, you aren't approved to edit this band"
        redirect_to bands_path
      end
    end
  end
  
  def update
    if @band.update(band_params)
      @genre = Genre.new(name: params[:new_genre])
      @genre.save
      @band.band_genres.create(genre_id: @genre.id)
      @band.band_genres.create(genre_id: params[:genre])
      flash[:notice] = "Band updated!"
      redirect_to band_path(@band)
    else
      flash[:notice] = "Band not updated"
      redirect_to edit_band_path(@band)
    end
  end
  
  private
  
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
      genre_ids: [],
      youtubes_attributes: [:link]
      )
    end
    
    def get_band
      @band = Band.find(params[:id])
    end

    def all_genres
      @genres = Genre.all
    end

    def find_friendly
      @band = Band.friendly.find(params[:id])
    end
    
    def soundcloud
      @client = Soundcloud.new(:client_id => 'b8e640fd38bce5816e3e15ca83bc75cc')
    end
end
