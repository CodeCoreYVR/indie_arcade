class ReviewsController < ApplicationController

  def show
    @game = Game.find params[:game_id]
    @reviews = @game.reviews
    @fun = 0
    @playability = 0
    @difficulty = 0
    @reviews.each do |rev|
      @fun += rev.fun.to_f
      @playability += rev.playability.to_f
      @difficulty += rev.difficulty.to_f
      @fun /= @reviews.count
      @playability /= @reviews.count
      @difficulty /= @reviews.count
    end
  end

end
