class MessagesController < ApplicationController
  respond_to :html

  def index
  end

  def create
    @message = ContactForm.new(name: params[:name], email: params[:email], message: params[:message])
    if @message.deliver
      redirect_to bands_path, :notice => 'Email has been sent.'
    else
      redirect_to bands_path, :notice => 'Email could not be sent.'
    end
  end

  private

     def message_params
     	params.require(:message).permit(:name, :email, :message)
     end
end