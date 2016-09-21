require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) {FactoryGirl.create :game}
  let(:user) {FactoryGirl.create :user}

  describe "#index" do
    it "redirects to index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "#show" do
    it "redirects to show view" do
      get :show
      expect(response).to render_template :show
    end
    it "defines an instance variable for game based on passed id" do
      get :show, params: { id: game.id }
      expect(assigns(:game)).to eq(game)
    end
  end

  describe "#edit" do
    context "with gamer" do
      it "redirect_to session new" do
        get :edit, {id: game.id}
        expect(response).to redirect_to root_path
      end
    end
    before {request.session[:user_id] = user.id}
    context "with dev" do
      it "redirects to edit view" do
        get :edit, {id: game.id} {}
        expect(response).to render_template :edit
      end
    end
    context "with admin" do
      it "redirects to edit view" do
        user.admin = true
        get :edit, {id: game.id}
        expect(response).to render_template :edit
      end
    end
  end

  describe "#new" do

  end

  describe "#create" do

  end

  describe "#update" do

  end

  describe "#destroy" do

  end

end
