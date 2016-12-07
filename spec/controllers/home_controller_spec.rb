require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  # test added to prevent regression
  context 'with invalid user_id in session' do
    render_views

    it 'clears user_id from session' do
      session[:user_id] = 8
      get :index
      expect(session[:user_id]).to be_nil
    end
  end

  describe '#index' do
    it 'renders the home page' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe '#about' do
    it 'renders the about page' do
      get :about
      expect(response).to render_template(:about)
    end
  end

  describe '#faq' do
    it 'renders the faq page' do
      get :faq
      expect(response).to render_template(:faq)
    end
  end
end
