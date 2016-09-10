class GamesController < ApplicationController
  def index
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

  private
  def find_game
    @game = Game.find params[:id]
  end

end
