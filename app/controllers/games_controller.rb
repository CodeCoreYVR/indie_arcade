class GamesController < ApplicationController

  def index
    @tags = Tag.all
    if params[:search]
      @games = User.search(params[:search]).includes(:games).map(&:games).flatten
    else
    @games = Game.all
    end
  end
end
