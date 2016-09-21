require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:user) { User.create password:"123456", email:"fake@fake.com", company:"Fake Co" }
  let(:admin) { User.create password:"123456564123", email:"admin_fake@fake.com", company:"Fake Co Admin" }
  let(:game) { Game.create title:"Fake Game 43895738", user: user, description:"This is a fake game description" }

  describe "#show" do

    it "defines an instance variable for game based on passed id" do
      get :show, params: { id: game.id }
      expect(assigns(:game)).to eq(game)
    end

    it "renders the show template" do
      get :show, params: { id: game }
      expect(response).to render_template(:show)
    end

    context "with signed in user" do
      it "is an admin" do
        session[:user_id] = admin.id
        get :show, params: { id: game }
        expect(response).to render_template(:show)
      end

      it "is a developer" do
        session[:user_id] = user.id
        get :show, params: { id: game }
        expect(response).to render_template(:show)
      end
    end


  end
end
