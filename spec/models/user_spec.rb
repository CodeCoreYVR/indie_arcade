require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    context "on a new user" do
      it "requires a valid email address" do
        user = User.new
        user.valid?
        expect(user.errors).to(have_key(:email))
      end

      it "requires a company presence" do
        user = User.new
        user.valid?
        expect(user.errors).to(have_key(:company))
      end

      it "should not be valid without a password" do
        user = User.new password: nil, password_confirmation: nil
        expect(user).not_to be_valid
      end

      it "should not be valid with a short password " do
        user = User.new password: 'short', password_confirmation: 'short'
        expect(user).not_to be_valid
      end

      it "should not be valid with a confirmation mismatch " do
        user = User.new password: 'short', password_confirmation: 'long'
        expect(user).not_to be_valid
      end
    end

    context "on an existing user" do
      let(:user) do
        u = User.create company: 'mcdonald', email: 'mcdonald@gmail.com', password: 'password', password_confirmation: 'password'
        User.find u.id
      end

      it "should be valid with no changes" do
        expect(user).to be_valid
      end

      it "should not be valid with same company" do
        b = User.create company: 'mcdonald', email: 'mcdonald@gmail.com', password: 'password', password_confirmation: 'password'
        b = User.create company: 'mcdonald', email: 'mcdonaldfastfood@gmail.com', password: 'password1', password_confirmation: 'password1'
        expect(b).not_to be_valid
      end

      it "should not be valid with same email" do
        b = User.create company: 'mcdonald', email: 'mcdonald@gmail.com', password: 'password', password_confirmation: 'password'
        b = User.create company: 'mcdonaldfastfood', email: 'mcdonald@gmail.com', password: 'password1', password_confirmation: 'password1'
        expect(b).not_to be_valid
      end

      it "should be valid with new matching password" do
        b = User.create company: 'mcdonaldfastfood', email: 'mcdonald@gmail.com', password: 'september', password_confirmation: 'september'
        expect(b).to be_valid
      end
    end


  end
end
