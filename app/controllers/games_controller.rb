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
      @games = @games.where(user_id: current_user.id).order("aasm_state='Rejected',aasm_state='Game not uploaded, it is not compatible with the system',aasm_state='Released to arcade',aasm_state='Not released', aasm_state= 'Game under review'")

    elsif user_is_admin?
      @statuses = Status.all
      @games = @games.order("aasm_state='Rejected',aasm_state='Game not uploaded, it is not compatible with the system',aasm_state='Released to arcade',aasm_state='Not released', aasm_state= 'Game under review'")
    else
      @games = @games.where(aasm_state: ["Released to Arcade","Not released"]).order("created_at ASC")
    end
      @games = Kaminari.paginate_array(@games).page(params[:page]).per(GAMES_PER_PAGE)
  end

  def show
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

  # Used to fulfill client requests for 5 new games
  def fill_machine_order(games)
    games.limit(5).order("RANDOM()")
  end
end
