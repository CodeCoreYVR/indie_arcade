require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # let(:user) {FactoryGirl.create :user}
  describe '#index' do
    it 'redirects the user to the home page(root_path)' do
      get :index
      # get the index action in the user controller
    expect(response).to redirect_to(root_path)
    end
  end

  let(:user){create(:user)}
  describe '#create' do
    context 'with valid params' do
      def valid_user
        post :create, params: {user: attributes_for(:user)}
      end

      it 'saves a user to the database'do
        count_before = User.count
        valid_user

        count_after = User.count
        expect(count_after).to equal(count_before + 1)
      end
    end
  end

  let(:user){create(:user)}
  describe '#create' do
    context 'with invalid params' do
      def invalid_user
        post :create, params: {user: attributes_for(:user)}
      end

      it 'does not save a user to the database' do
        count_before = User.count
        invalid_user

        count_after = User.count
        expect(count_after).to equal(count_before)
      end
      

    end
  end

end
