class KeysController < ApplicationController
  def new
    @game = Game.find_by_id params[:game_id]
    @keys = @game.key_map ? JSON.parse(@game.key_map) : {}
  end

  def create
    @game = Game.find_by_id params[:game_id]
    @game.key_map = params[:key].to_json
    @game.save
    @keys = @game.key_map ? JSON.parse(@game.key_map) : {}
    render :new
  end
end
