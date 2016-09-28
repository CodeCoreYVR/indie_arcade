class KeysController < ApplicationController
  def new
    @game = Game.find_by_id params[:game_id]
    @keys = JSON.parse(@game.key_map)
  end

  def create
    @game = Game.find_by_id params[:game_id]
    @game.key_map = params[:key].to_json
    @game.save
    redirect_to new_game_key_path(@game)
  end
end
