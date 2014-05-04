class SlidesController < ApplicationController
	before_filter :only_bloggers!
  before_action :set_slide, only: [:edit, :update, :destroy]

	def new
		@slide = Slide.new
	end

	def create
		@slide = Slide.new(slide_params)	
		if @slide.save
			flash[:notice] = "Slide created..."
			redirect_to blog_admin_path
		else
			flash[:notice] = "Slide not created!"
			render :new
		end
	end

	def edit
	end

	def update
		if @slide.update(slide_params)
			flash[:notice] = "Slide updated"
			redirect_to blog_admin_path
		else
			flash[:notice] = "Slide wasn't updated"
			redirect_to blog_admin_path
		end
	end

	def destroy
		if @slide.destroy
			flash[:notice] = "Slide deleted"
			redirect_to blog_admin_path
		else
			flash[:notice] = "Slide wasn't deleted"
			redirect_to blog_admin_path
		end
	end

	private
	  def slide_params
	  	params.require(:slide).permit(:en_title, :ko_title, :en_description, :ko_description,
	  		:active, :link, :anchor, :image)
	  end

	  def set_slide
	  	@slide = Slide.find(params[:id])
	  end

	  def only_bloggers!
	  	unless (current_user.present? && current_user.blogger == true)
	  		redirect_to root_path
	  		flash[:notice] = "Sorry, you aren't authorized"
	  	end
	  end
end