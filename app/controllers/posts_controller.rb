class PostsController < ApplicationController
  before_filter :blogger!, only: [:admin, :edit, :update, :new, :destroy, :create]
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  before_action :set_ads, only: [:show, :index]
  def index
    if params[:tag]
      @posts = Post.published.tagged_with(params[:tag]).order(created_at: :desc)
      @categories = Category.all
    else
      @posts = Post.published.order(created_at: :desc)
      @categories = Category.all
    end
  end
  
  def show
    @categories = Category.all
  end
  
  def new
    @post = Post.new
    @post.build_slide
    @categories = Category.all
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      @category = Category.new(name: params[:new_category])
      @category.save
      @post.post_categories.create(category_id: @category.id)
      # @band.band_genres.create(genre_id: params[:genre])
      flash[:notice] = "Post Created!"
      redirect_to posts_path
    else
      flash[:notice] = "Post wasn't created"
      redirect_to new_post_path
    end
  end
  
  def admin
    @posts = Post.admin_search(params[:search], params[:page])
  end
  
  def edit
    @post.build_slide if @post.slide.nil?
    @categories = Category.all
  end
  
  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated"
      redirect_to blog_admin_path
    else
      flash[:notice] = "Post wasn't updated"
      redirect_to edit_post_path(@post)
    end
  end
  
  private
    def get_post
      @post = Post.friendly.find(params[:id]) #this needs to change when routing is changed
    end
    
    def post_params
      params.require(:post).permit(
        :title,
        :ko_title,
        :en_body,
        :ko_body,
        :short_title,
        :published,
        :tag_list,
        :image,
        category_ids: [],
        tag_ids: [],
        band_ids: [],
        slide_attributes: [:en_title, :ko_title, :en_description, :ko_description, :image, :link, :anchor, :active, :id, :_destroy])
    end

    def blogger!
      unless current_user.present? && current_user.blogger == true
        flash[:alert] = "Sorry, bloggers only"
        redirect_to blog_path
      end
    end

    def set_ads
      @ads = Ad.all
    end
end
