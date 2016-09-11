class GamesController < ApplicationController
  before_action :find_game, only: [:show, :update]

  def index
    # byebug
    @tags = Tag.all
    @tagsearch = Tag.ids.map{|x| x.to_s}
    if params[:search_user]
      @games = User.search(params[:search_user]).includes(:games).map(&:games).flatten
    elsif (@tagsearch & params.keys).empty?
      @games = Game.all
    else
      @games = Tag.where(id: (@tagsearch & params.keys)).map{|k| k.games}.flatten
      @games.uniq
    end
  end

  def show
    # find_game
    @developer = @game.user.company
    @date = @game.created_at
    @play_times = @game.reviews.count
    # review_collection = @game.reviews.order(created_at: :desc)
    @last_played = @game.reviews.last ? @game.reviews.last.created_at : "Never"
    @rating = review_score_for @game
  end

  def update
    # render json: params
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

  private
  def find_game
    @game = Game.find params[:id]
  end

  def game_params
    params.require(:game).permit(:title, :cpu, :gpu, :ram, :size, :approval_date, :status_id, :stats, :description, :picture, :link)
  end

  def review_score_for( game )
    game.reviews.count
    # (review_collection.average(:fun) + review_collection.average(:playability) + review_collection.average(:difficulty))/3
  end
end
