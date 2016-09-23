class HomeController < ApplicationController

  def contact
    @message = Message.new
    @messages = Message.all
  end
  
  def index
  end

  def about
  end

  def faq
  end

end
