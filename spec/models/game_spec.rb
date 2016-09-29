require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'has a unique title' do
    older_game = Game.create(title: 'Game')
    new_game = Game.new(title: 'Game')
    new_game.save
    expect(new_game.errors).to have_key :title
  end

  it 'returns a list of titles' do
    game1 = Game.create(title: 'bobGames')
    game1 = Game.create(title: 'newBob')
    game1 = Game.create(title: 'john')
    outcome = Game.search('bob')
    expect(outcome.map(&:title)).to eq %w(bobGames newBob)
  end

  it 'returns a list of companies containing name' do
    user1 = User.create(company: 'bobGames')
    user2 = User.create(company: 'newBob')
    user3 = User.create(company: 'john')
    user1.games.create(title: 'game1')
    user1.games.create(title: 'game2')
    user1.games.create(title: 'game3')
    user2.games.create(title: 'game4')
    user3.games.create(title: 'game5')
    user2.games.create(title: 'game6')
    outcome = Game.with_company_containing('new')
    expect(outcome.map(&:title)).to eq %w(game6 game4)
  end

  it 'returns approved games status 1 or 2' do
    game1 = Game.create(title: 'game1', status_id: 1)
    game2 = Game.create(title: 'game2', status_id: 2)
    game3 = Game.create(title: 'game3', status_id: 3)
    game4 = Game.create(title: 'game4', status_id: 4)
    game5 = Game.create(title: 'game5', status_id: 2)
    outcome = Game.approved
    expect(outcome.map(&:title)).to eq %w(game1 game2 game5)
  end
end
