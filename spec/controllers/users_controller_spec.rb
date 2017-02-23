require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#index' do
    it 'redirects to home page' do
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  let(:user){ create(:user) }
  describe '#create' do
    context 'with valid params' do
      def valid_user
        post :create, params: { user: attributes_for(:user)}
      end

      it 'saves a record to the database' do
        count_before = User.count
        valid_user

        count_after = User.count
        expect(count_after).to eq(count_before + 1)
      end

      it 'saves session id of current user' do
        # u = create(:user)
        # expect(session[:user_id]).to eq(u.id)

        valid_user
        expect(session[:user_id]).not_to eq(nil)
      end
    end

    context 'with invalid params' do
      def invalid_user
        post :create, params: { user: attributes_for(:user, email: nil)}
      end

      it 'does not save a record to the database' do
        count_before = User.count
        invalid_user

        count_after = User.count
        expect(count_after).to eq(count_before)
      end

      it 'renders the new template' do
        invalid_user
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#show' do
    it 'renders the show template' do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end

    it 'user id is passed' do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end

end
