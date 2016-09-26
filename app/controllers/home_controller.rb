class HomeController < ApplicationController

  def contact
    @message = Message.new
    @messages = Message.all
  end

  def index
    @messages = Message.order(created_at: :desc)
  end

  def about
  end

  def faq
  end

end
