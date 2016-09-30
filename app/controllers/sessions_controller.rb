class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:email]
    session[:user_id] = user.id if user&.authenticate(params[:password])
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
