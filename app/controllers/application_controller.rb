class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_signed_in?
  session[:user_id].present?
  end
  helper_method :user_signed_in?
# adding a helper_method call as in above, allows the view files (all of them
# in this case) to have access to this method

  def current_user
  # the technique below is called memoization which fetched the user in this
  # case the first time you call the method and every subsequent time it uses
  # the one stored in the `@current_user` variable
    if user_signed_in?
      @current_user ||= User.find session[:user_id]
    end
  end

  def user_admin?
  # the technique below is called memoization which fetched the user in this
  # case the first time you call the method and every subsequent time it uses
  # the one stored in the `@current_user` variable
    user_signed_in? && current_user.admin?
  end

helper_method :current_user

  def authenticate_user!
    redirect_to new_session_path unless user_signed_in?
  end

end
