require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "#index" do
    it "renders the home page" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#about" do
    it "renders the about page" do
      get :about
      expect(response).to render_template(:about)
    end
  end

  describe "#faq" do
    it "renders the faq page" do
      get :faq
      expect(response).to render_template(:faq)
    end
  end
end
