require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'has a unique title' do
    older_game = FactoryGirl.create(:game)
    new_game = FactoryGirl.create(:game)
    new_game.title = older_game.title
    expect(new_game).not_to be_valid
  end
  it 'returns a list of titles with words that start with the search term' do
    FactoryGirl.create(:game, title: 'bobGames')
    FactoryGirl.create(:game, title: 'Mr. bob and friends')
    FactoryGirl.create(:game, title: 'newBob')
    FactoryGirl.create(:game, title: 'john')
    FactoryGirl.create(:game, title: 'dog Bobsakus')
    outcome = Game.search_by('main', 'bob')
    expect(outcome.map(&:title)).to eq(["bobGames", "Mr. bob and friends", "dog Bobsakus"])
  end
end
