class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to root_path
  end

  def show
    @user = User.find params[:id]
    @games = @user.games
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :company, :email, :password, :password_confirmation,
      :logo, :employees, :genres, :website, :twitter, :admin
    )
  end
end
