class GamesController < ApplicationController
  before_action :find_game, only: [:show, :update, :edit]

  GAMES_PER_PAGE = 6

  def index
    @tags = Tag.all
    @tagsearch = Tag.ids.map{|x| x.to_s}
    searched = params.require(:tag)[:tag_ids] unless params[:tag].nil?
    searched = params[:search] unless params[:search].nil?
    searched = params[:search_user] unless params[:search_user].nil?
    searched = params.require(:search_status)[:status].to_i unless params[:search_status].nil?
    searched = params[:search_main] unless params[:search_main].nil?

    if searched.is_a?(Array)
        searched.each do |t|
            @games.nil? ? @games = Tag.find(t).games : @games + Tag.find(t).games
          end
       @games.uniq

    elsif searched.nil?
      @games = Game.all
    elsif searched.is_a?(Integer)
      @games = Game.where(status_id: searched)
    elsif searched == params[:search_user]
      @games = Game.with_company_containing(searched)
    elsif searched == params[:search_main]
      @games = Game.search(searched)
    end


    if user_is_dev?
      @games = @games.where(user_id: current_user.id)
    elsif user_is_admin?
      @statuses = Status.all
      @games
    else
      @games = @games.where(status_id: [1,2])
    end
      @games = @games.page(params[:page]).per(GAMES_PER_PAGE)
    respond_to do |format|
      format.html {render}
      format.json {render json: fill_machine_order(Game.all)}
    end
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
    @difficulty = @reviews.average(:difficulty)
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
    # (review_collection.average(:fun) + review_collection.average(:playability) + review_collection.average(:difficulty))/3
  end

  def fill_machine_order(games)
    games.order(:id).take(5)
  end
end
