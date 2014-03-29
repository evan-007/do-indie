class Admin::SlidesController < ApplicationController
	before_action :get_slide, only: [:show, :edit, :update, :destroy]

	def index
		@slides = Slide.order(active: :asc)
	end

	def new
		@slide = Slide.new
	end

	def create
		@slide = Slide.new(slide_params)
		if @slide.save
			flash[:notice] = "Slide created!"
			redirect_to admin_slides_path
		else
			flash[:notice] = "Slide was not created!"
			redirect_to new_admin_slide_path
		end
	end

	def show
		redirect_to edit_admin_slide_path(@slide)
	end

	def edit
	end

	def update
		if @slide.update(slide_params)
			flash[:notice] = "Slide updated!"
			redirect_to admin_slides_path
		else
			flash[:notice] = "Slide wasn't updated!"
			redirect_to edit_admin_slide_path(@slide)
		end
	end


    private

        def slide_params
        	params.require(:slide).permit(:ko_title, :en_title, :ko_description,
        		:en_description, :anchor, :link, :image, :active)
        end

        def get_slide
        	@slide = Slide.find(params[:id])
        end
end
