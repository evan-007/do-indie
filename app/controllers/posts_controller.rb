class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.published
  end
  
  def show
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:notice] = "Post Created!"
      redirect_to posts_path
    else
      flash[:notice] = "Post wasn't created"
      redirect_to new_post_path
    end
  end
  
  private
    def get_post
      @post = Post.find(params[:id]) #this needs to change when routing is changed
    end
    
    def post_params
      params.require(:post).permit(
        :title,
        :en_body,
        :ko_body,
        :short_title,
        :published)
    end
end
