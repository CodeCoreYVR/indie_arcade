class GamesController < ApplicationController
  before_action :find_game, only: [:show, :update, :edit]

  GAMES_PER_PAGE = 6

  def index
    @tags = Tag.all

    if params[:search_user]
      @games = Game.user_data_subset(user_is_admin?,user_is_dev?,current_user.nil? ? nil : current_user.id).search_by('user',params[:search_user]).order(desired_order)
    elsif params[:search_main]
      @games = Game.user_data_subset(user_is_admin?,user_is_dev?,current_user.nil? ? nil : current_user.id).search_by('main',params[:search_main]).order(desired_order)
    elsif params[:tag]
      @games = Game.user_data_subset(user_is_admin?,user_is_dev?,current_user.nil? ? nil : current_user.id).search_by('tags',params.require(:tag)[:tag_ids]).order(desired_order)
    else
      @games = Game.user_data_subset(user_is_admin?,user_is_dev?,current_user.nil? ? nil : current_user.id).order(desired_order)
    end
      @games = @games.page(params[:page]).per(GAMES_PER_PAGE)
  end

  def show
    find_game
    @developer = @game.user.company
    @date = @game.created_at
    @play_times = @game.reviews.count
    # review_collection = @game.reviews.order(created_at: :desc)
    @last_played = @game.reviews.last ? @game.reviews.last.created_at : "Never"
    @rating = review_score_for @game

    @reviews = @game.reviews
    # get review statistics
    @fun = @reviews.average(:fun)
    @playability = @reviews.average(:playability)
    @difficulty  = @reviews.average(:difficulty)
  end

  def update
    game = Game.find params[:id]

    respond_to do |format|
      if game.update(game_params)
        format.html { redirect_to @game, notice: 'Game status was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
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
        format.html { redirect_to games_path, notice: 'Game was successfully uploaded.' }
        format.json { render :index, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def destroy
    g=Game.find params[:id]
    g.destroy
    redirect_to games_path
  end


  private

  def find_game
    @game = Game.find params[:id]
  end

  def game_params
    params.require(:game).permit(:title, :cpu, :gpu, :ram, :size, :approval_date, :status_id, :stats, :description, :picture, :link, {tag_ids: [] } )
  end

  def review_score_for( game )
    game.reviews.count
  end

  def fill_machine_order(games)
    games.limit(5).order("RANDOM()")
  end

  def desired_order
    if user_signed_in?
    "aasm_state='Rejected',aasm_state='Game not uploaded, it is not compatible with the system',aasm_state='Released to arcade',aasm_state='Not released', aasm_state= 'Game under review'"
    else
    "aasm_state='Not released',aasm_state='Released to arcade'"
    end
  end
end
