require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    it "requires a valid email address" do
      user = User.new
      user.valid?
      expect(user.errors).to(have_key(:email))
    end

    it "requires a company presence" do
      user = User.new
      user.valid?
      expect(message.errors).to(have_key(:company))
    end

    it "requires a company presence" do
      user = User.new
      user.valid?
      expect(message.errors).to(have_key(:company))
    end

    it "requires a company presence" do
      user = User.new
      user.valid?
      expect(message.errors).to(have_key(:company))
    end

    it "requires a password presence" do
      user = User.new
      user.valid?
      expect(message.errors).to(have_key(:password))
    end

    it "requires a password presence" do
      user = User.new
      user.valid?
      expect(message.errors).to(have_key(:password))
    end


  end
end
