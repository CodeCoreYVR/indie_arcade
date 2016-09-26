require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  let(:user) { FactoryGirl.create :user }
  let(:message) { FactoryGirl.create :message }

  describe "#new" do
    before { request.session[:user_id] = user.id }
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new message instance variable" do
      get :new
      expect(assigns(:message)).to be_a_new(Message)
    end
  end

  describe "#create" do
    before { request.session[:user_id] = user.id }
    context "with valid parameters" do
      def valid_message_request
        FactoryGirl.create :message
      end

      it "saves a message to the message table" do
        count_before = Message.count
        valid_message_request
        count_after = Message.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the message show page" do
        request.session[:user_id] = user.id
        attrs = FactoryGirl.attributes_for(:message)
        post :create, params: { message: attrs }
        expect(response).to redirect_to(message_path(Message.last))
      end
    end

    context "with invalid parameters" do
      before { request.session[:user_id] = user.id }
      def invalid_message_request
        post :create, params: { message: { email: "", content: nil } }
      end

      it "renders the new message template" do
        invalid_message_request
        expect(response).to render_template(:new)
      end

      it "doesn't save the record to the database" do
        count_before = Message.count
        invalid_message_request
        count_after = Message.count
        expect(count_after).to eq(count_before)
      end
    end
  end

  describe "#index" do
    context "user has admin status" do
      def set_admin
        session[:user_id] = user.id
        user.admin = true
        user.save
      end
      it "renders index page" do
        set_admin
        get :index
        expect(response).to render_template(:index)
      end

      it "instantiates messages to be all messages" do
        set_admin
        message1 =  FactoryGirl.create :message
        message2 = FactoryGirl.create :message
        get :index
        expect(assigns(:messages)).to eq([message1, message2])
      end
    end

    context "user does not have admin status" do
      it "redirects to the login page (sessions new)" do
        request.session[:user_id] = user.id
        get :index
        expect(response).to redirect_to(new_session_path)
      end

    context "no user no admin status" do
      it "redirects to the login page (sesssions new)" do
        get :index
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  end
end
