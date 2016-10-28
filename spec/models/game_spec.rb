require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'has a unique title' do
    older_game = FactoryGirl.create(:game)
    new_game = FactoryGirl.create(:game)
    new_game.title = older_game.title
    expect(new_game).not_to be_valid
  end
end
