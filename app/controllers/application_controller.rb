class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_signed_in?
  session[:user_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    if user_signed_in?
      @current_user ||= User.find session[:user_id] if user_signed_in?
    end
  end

  helper_method :current_user

  def user_is_admin?
    user_signed_in? && current_user.admin
  end
  helper_method :user_is_admin?

  def user_is_dev?
    user_signed_in? && (current_user.admin == false)
  end
  helper_method :user_is_dev?

  def user_is_gamer?
    user_signed_in? == false
  end
  helper_method :user_is_gamer?

  def authenticate_user!
    redirect_to new_session_path unless user_signed_in?
  end

  def authorize
    redirect_to root_path, alert: "Access denied" unless can? :manage, @question
  end
end
