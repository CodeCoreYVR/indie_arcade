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
      get :show, {id: game.id}
      expect(response).to render_template :show
    end
    it "defines an instance variable for game based on passed id" do
      get :show, params: { id: game.id }
      expect(assigns(:game)).to eq(game)
    end
  end

  describe "#edit" do
    context "with gamer" do
      it "redirects to session new" do
        get :edit, {id: game.id}
        expect(response).to redirect_to new_session_path
      end
    end
    context "with dev or admin" do
      context "owns game" do
        it "redirects to edit view" do
          get :edit, params: {id: game.id}, session: { user_id: game.user_id }
          expect(response).to render_template :edit
        end
      end
      context "doesn't own game" do
        it "redirects to root path" do
          get :edit, params: {id: game.id}, session: { user_id: user.id }
          expect(response).to redirect_to root_path
        end
      end
    end
    context "with admin" do
      it "redirects to edit view" do
        user.admin = true
        user.save
        get :edit, params: {id: game.id}, session: { user_id: user.id }
        expect(response).to render_template :edit
      end
    end
  end

  describe "#new" do
    context "with gamer" do
      it "redirect_to user login" do
        get :new
        expect(response).to redirect_to new_session_path
      end
    end
    context "with dev" do
      before {request.session[:user_id] = user.id}
      it "renders the new page" do
        get :new
        expect(response).to render_template :new
      end
    end
    context "with admin" do
      before {request.session[:user_id] = user.id}
      it "renders the new page" do
        user.admin = true
        user.save
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe "#create" do
    it "redirects to game_path" do
      post :create, params: { game: FactoryGirl.attributes_for(:game) }, session: { user_id: user.id }
      expect(response).to redirect_to games_path
    end
  end

  describe "#update" do
    it "redirect_to game's show " do
      patch :update, params: { id: game.id, game: FactoryGirl.attributes_for(:game) }, session: { user_id: game.user_id }
      expect(response).to redirect_to game_path(game.id)
    end
  end

  describe "#destroy" do
    context "dev with ownership" do
      it "redirect_to games index" do
        delete :destroy, params: { id: game.id }, session: { user_id: game.user_id }
        expect(response).to redirect_to games_path
      end
    end
    context "dev without ownership" do
      it "redirect_to root path" do
        delete :destroy, params: { id: game.id }, session: { user_id: user.id }
        expect(response).to redirect_to root_path
      end
    end
    context "admin" do
      it "redirect_to games index" do
        user.admin = true
        user.save
        delete :destroy, params: { id: game.id }, session: { user_id: game.user_id }
        expect(response).to redirect_to games_path
      end
    end
  end

end
