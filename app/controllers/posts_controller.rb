class PostsController < ApplicationController
  before_filter :blogger!, only: [:admin, :edit, :update, :new, :destroy, :create]
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  before_action :set_ads, only: [:show, :index, :tags]

  def index
    @posts = Post.index_search(params[:query], params[:page])
    @categories = Category.all
  end
  
  def show
    @categories = Category.all
  end
  
  def new
    @post = Post.new
    @categories = Category.all
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      @category = Category.new(name: params[:new_category])
      @category.save
      @post.post_categories.create(category_id: @category.id)
      flash[:notice] = "Post Created!"
      redirect_to posts_path
    else
      flash[:notice] = "Post wasn't created"
      redirect_to new_post_path
    end
  end
  
  def admin
    @posts = Post.admin_search(params[:query], params[:page])
    @slides = Slide.all
  end
  
  def edit
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

  def tags
    @posts = Post.published.tagged_with(params[:tag]).order(created_at: :desc)
    @categories = Category.all
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
        :category_tokens,
        category_ids: [],
        tag_ids: [],
        band_ids: [],
        category_attributes: [:id, :name])
    end

    def blogger!
      unless current_user.present? && current_user.blogger == true
        flash[:alert] = "Sorry, bloggers only"
        redirect_to blog_path
      end
    end

    def set_ads
      @ads = Ad.take(4)
    end
end
