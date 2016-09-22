class MessagesController < ApplicationController
  before_action :authenticate_admin!, only: [:index]

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new params.require(:message).permit(:email, :content)

    if @message.save
      redirect_to message_path(@message)
    else
      render :new
    end
  end

  def index
    @messages = Message.all
  end

end
