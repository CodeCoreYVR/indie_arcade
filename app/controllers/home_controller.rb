class HomeController < ApplicationController

  def contact
    @message = Message.new
    @messages = Message.all
  end

  def create
    message_params = params.require(:message).permit([:emailadd, :content])
    @message       = Message.create message_params
    if @message.save
      redirect_to contact_path
    else
      render :new
    end
  end

  def index
    @messages = Message.order(created_at: :desc)
  end

  def about
  end

end
