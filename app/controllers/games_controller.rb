class GamesController < ApplicationController
  def index
    @tags = Tag.all
    if params[:search]
      @games = User.search(params[:search]).includes(:games).map(&:games).flatten
    else
    @games = Game.all
    end
  end


  def show
    find_game
    @developer = @game.user.company
    @date = @game.user.create_at
    @play_times = @game.reviews.count
    review_collection = @game.reviews.order(created_at: :desc)
    @last_played = review_collection.first.created_at
    @rating = (review_collection.average(:fun) + review_collection.average(:playability) + review_collection.average(:difficulty))/3
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
    params.require(:game).permit(:title, :cpu, :gpu, :ram, :size, :approval_date, :current_status, :stats, :description, :picture, :link)
  end
end
