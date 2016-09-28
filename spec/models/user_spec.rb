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
      let(:user) {FactoryGirl.create(:user)}
      it "should be a valid user" do
        u = User.find user.id
        expect(u).to be_valid
      end

      it "should not be valid with same company" do
        b = FactoryGirl.create(:user)
        c = FactoryGirl.create(:user)
        c.company = b.company
        expect(c).not_to be_valid
      end

      it "should not be valid with same email" do
        b = FactoryGirl.create(:user)
        c = FactoryGirl.create(:user)
        c.email = b.email
        expect(c).not_to be_valid
      end

      it "should be valid with new matching password" do
        b = FactoryGirl.create(:user)
        b.password = "december"
        b.password_confirmation = "december"
        expect(b).to be_valid
      end
    end


  end
end
