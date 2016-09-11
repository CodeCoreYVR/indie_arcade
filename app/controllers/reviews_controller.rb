class ReviewsController < ApplicationController

  def show
    @game = Game.find params[:game_id]
    @reviews = @game.reviews

    review_collection = @game.reviews
    @fun = review_collection.average(:fun).round(3)
    @playability = review_collection.average(:playability).round(3)
    @difficulty = review_collection.average(:difficulty).round(3)

  end

end
