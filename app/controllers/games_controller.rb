class GamesController < ApplicationController
  before_action :find_game, only: [:show, :update, :edit]
  before_action :authenticate_user!, except: [:index, :show]

  GAMES_PER_PAGE = 6

  def index
    @tags = Tag.all

    if params[:search_user]
      @games = Game.user_data_subset(
        user_is_admin?, user_is_dev?, current_user&.id
      ).search_by('user', params[:search_user]).order(desired_order)
    elsif params[:search_main]
      @games = Game.user_data_subset(
        user_is_admin?, user_is_dev?, current_user&.id
      ).search_by('main', params[:search_main]).order(desired_order)
    elsif params[:tag]
      @games = Game.user_data_subset(
        user_is_admin?, user_is_dev?, current_user&.id
      ).search_by('tags', params.require(:tag)[:tag_ids]).order(desired_order)
    else
      @games = Game.user_data_subset(
        user_is_admin?, user_is_dev?, current_user&.id
      ).order(desired_order)
    end
    @games = @games.page(params[:page]).per(GAMES_PER_PAGE)
  end

  def show
  end

  def update
    game = Game.find params[:id]
    if cannot? :manage, game
      redirect_to root_path
    elsif game.update(game_params)
      redirect_to @game, notice: 'Game status was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user

    respond_to do |format|
      if @game.save
        format.html do
          redirect_to games_path,
                      notice: 'Game was successfully uploaded.'
        end
        format.json { render :index, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    game = Game.find params[:id]
    redirect_to root_path if cannot? :manage, game
  end

  def destroy
    game = Game.find params[:id]
    if cannot? :manage, game
      redirect_to root_path
    else
      game.destroy
      redirect_to games_path
    end
  end

  private

  def find_game
    @game = Game.find params[:id]
  end

  def game_params
    params.require(:game).permit(:title, :cpu, :gpu, :ram, :size,
                                 :approval_date, :status_id, :stats,
                                 :description, :picture, :attachment,
                                 :link, tag_ids: [])
  end

  # Used to fulfill client requests for 5 new games
  def fill_machine_order(games)
    games.limit(5).order('RANDOM()')
  end

  def desired_order
    if user_signed_in?
      "aasm_state='Rejected',aasm_state='Game not uploaded,
      it is not compatible with the system',aasm_state='Released to arcade',
      aasm_state='Not released', aasm_state= 'Game under review'"
    else
      "aasm_state='Not released',aasm_state='Released to arcade'"
    end
  end
end
