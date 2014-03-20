class BandsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :find_friendly, only: [:show, :edit, :update, :destroy]
  before_action :all_genres, only: [:new, :edit]
  before_action :soundcloud, only: [:show]
  
  def index
    @bands = Band.search_and_order(params[:search], params[:page])
    @genres = Genre.all
  end
  
  def new
    @band = Band.new
  end
  
  def create
    @band = Band.new(band_params)
    if @band.save
      @genre = Genre.new(name: params[:new_genre])
      @genre.save
      @band.band_genres.create(genre_id: @genre.id)
      @band.band_genres.create(genre_id: params[:genre])
      flash[:notice] = "Band created!"
      redirect_to band_path(@band)
    else
      flash[:notice] = "Band not created!"
      render :new
    end
  end
  
  def show
    @track_url = @band.soundcloud
    @embed_info = @client.get('/oembed', :url => @track_url )
    unless @band.twitter == nil
      @tweet_url = @band.twitter.gsub(/^[^_]*twitter.com\//, '')
    end
  end
  
  def edit
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
    :ko_bio,
    :avatar
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
