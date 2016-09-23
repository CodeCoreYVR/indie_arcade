require 'rails_helper'

RSpec.describe Game, type: :model do

    it "has a unique title" do
      older_game = Game.create(title:"Game")
      new_game = Game.new(title:"Game")
      new_game.save
      expect(new_game.errors).to have_key :title
    end

      it "returns a list of titles" do
        game1 = Game.create(title:"bobGames")
        game1 = Game.create(title:"newBob")
        game1 = Game.create(title:"john")
        outcome = Game.search("bob")
        expect(outcome.map(&:title)).to eq ["bobGames", "newBob"]
      end
end
