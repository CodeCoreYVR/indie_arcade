require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'has a unique title' do
    older_game = FactoryGirl.create(:game)
    new_game = FactoryGirl.create(:game)
    new_game.title = older_game.title
    expect(new_game).not_to be_valid
  end

  it 'returns a list of titles' do
    FactoryGirl.create(:game, title: 'bobGames')
    FactoryGirl.create(:game, title: 'newBob')
    FactoryGirl.create(:game, title: 'john')
    outcome = Game.search('bob')
    expect(outcome.map(&:title)).to eq(%w(bobGames newBob))
  end
end
