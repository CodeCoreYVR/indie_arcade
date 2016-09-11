class AddGameToReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :game, foreign_key: true
  end
end
