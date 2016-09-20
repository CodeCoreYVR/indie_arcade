require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "#show" do
    def create_valid_user
      User.create password:"123456", email:"fake@fake.com", company:"Fake Co"
    end

    def create_valid_game
      Game.create title:"Fake Game 43895738", user:create_valid_user, description:"This is a fake game description"
    end

    it "renders the show template" do
      get :show, params: { id: create_valid_game.id }
      expect(response).to render_template(:show)
    end

    it "defines an instance variable for game based on passed id" do
      game = create_valid_game

      get :show, params: { id: game.id }
      expect(assigns(:game)).to eq(game)
    end
  end
end
