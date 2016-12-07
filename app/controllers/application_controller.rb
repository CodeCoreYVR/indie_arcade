class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user
    redirect_to(
      new_session_path,
      alert: 'Please Sign In!'
    ) unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    clear_session_user if @current_user.nil? && session[:user_id].present?
    @current_user
  end
  helper_method :current_user

  def user_is_admin?
    user_signed_in? && current_user.admin
  end
  helper_method :user_is_admin?

  def user_is_dev?
    user_signed_in? && !current_user.admin
  end
  helper_method :user_is_dev?

  def user_is_gamer?
    !user_signed_in?
  end
  helper_method :user_is_gamer?

  def authenticate_user!
    redirect_to new_session_path unless user_signed_in?
  end

  def authenticate_admin!
    redirect_to new_session_path unless user_is_admin?
  end

  def authorize
    redirect_to root_path, alert: 'Access denied' unless can? :manage, @question
  end

  private

  def clear_session_user
    session[:user_id] = nil
  end
end
