class GamesController < ApplicationController
  before_action :find_game, only: [:show, :update, :edit]
  before_action :authenticate_user!, except: [:index, :show]

  GAMES_PER_PAGE = 6

  def index
    @states = Game.aasm.states.map(&:name)
    @state = params[:search_state]
    @tags = Tag.all
    if params[:user_id]
      user = User.find params[:user_id]
      @games = user.games
    else
      @games = search(game_subset)
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
    elsif params[:commit]
      toggle_state(game)
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

    if @game.save
      redirect_to games_path, notice: 'Game was successfully uploaded.'
    else
      render :new
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

  def toggle_state(game)
    params[:commit] == Game::STATE_APPROVE ? game.approve : game.reject
    game.save
    redirect_to game
  end

  private

  def game_subset
    Game.user_data_subset(user_is_admin?, user_is_dev?, current_user&.id)
  end

  def search(subset)
    if params[:search_user]
      subset.search_by('user', params[:search_user])
    elsif params[:tag]
      subset.search_by('tags', params.require(:tag)[:tag_ids])
    elsif params[:search_main]
      subset.search_by('main', params[:search_main])
    elsif params[:search_state]
      subset.search_by('state', params[:search_state])
    else
      subset
    end
  end

  def find_game
    @game = Game.find(params[:id]).decorate
  end

  def game_params
    params.require(:game).permit(:title, :cpu, :gpu, :ram,
                                 :size, :approval_date,
                                 :status_id, :stats,
                                 :description, { pictures: [] },
                                 :attachment, :link,
                                 { tag_ids: [] }, :aasm_state)
  end

  # Used to fulfill client requests for 5 new games
  def fill_machine_order(games)
    games.limit(5).order('RANDOM()')
  end

  def alter_aasm(game)
    if params[:commit] == Game::STATE_APPROVE
      game.approve
    elsif params[:commit] == Game::STATE_REJECT
      game.reject
    end
    game.save
    redirect_to @game, notice: 'Game state was successfully updated.'
  end
end
