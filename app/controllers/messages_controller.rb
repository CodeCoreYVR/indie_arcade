class MessagesController < ApplicationController
  before_action :authenticate_admin!, only: [:index]

  MESSAGES_PER_PAGE = 6

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
    @messages = Message.page(1).per(4)
  end

  def destroy
    m=Message.find params[:id]
    m.destroy
    redirect_to messages_path
  end

end
