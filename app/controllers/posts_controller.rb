class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.published
  end
  
  def show
  end
  
  def new
    @post = Post.new
    @post.build_slide
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Post Created!"
      redirect_to posts_path
    else
      flash[:notice] = "Post wasn't created"
      redirect_to new_post_path
    end
  end
  
  def admin
    @posts = Post.order(created_at: :desc)
  end
  
  def edit
    @post.build_slide if @post.slide.nil?
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
        slide_attributes: [:en_title, :ko_title, :en_description, :ko_description, :image, :link, :anchor, :active, :id])
    end
end
