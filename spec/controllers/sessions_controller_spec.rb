require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) {FactoryGirl.create :user}

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "#create" do
    context "with valid credentials" do
      it "redirects to root path" do
        post :create, params: { password: user.password, email: user.email }
        expect(response).to redirect_to root_path
      end
      it "sets session to user_id" do
        session[:user_id] = nil
        post :create, params: { password: user.password, email: user.email }
        expect(session[:user_id]).to eq(user.id)
      end
    end
    context "with invalid credentials" do
      it "redirects to root path" do
        user.password = 'invalidpassword'
        post :create, params: { password: user.password, email: user.email }
        expect(response).to redirect_to root_path
      end
      it "does not set session to user_id" do
        session[:user_id] = nil
        user.password = 'invalidpassword'
        post :create, params: { password: user.password, email: user.email }
        expect(session[:user_id]).to eq(nil)
      end
    end
  end

  describe "#destroy" do
    it "redirects to root path" do
      post :destroy
      expect(response).to redirect_to root_path
    end
    it "sets session to nil" do
      session[:user_id] = user.id
      post :destroy
      expect(session[:user_id]).to eq(nil)
    end
  end

end
