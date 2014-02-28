class EventsController < ApplicationController
	before_action :get_event, only: [:show, :edit, :update, :destroy]
	def index
		@events = Event.all
	end

	def show
	end

	private
	  def get_event
	  	@event = Event.find(params[:id])
	  end
end
