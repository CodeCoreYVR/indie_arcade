require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "validations" do
    it "requires a valid email address" do
      message = Message.new
      message.valid?
      expect(message.errors).to(have_key(:email))
    end

    it "requires a description presence" do
      message = FactoryGirl.create :invalidmessage
      message.valid?
      expect(message.errors).to(have_key(:content))
    end

    it "requires a description to be longer than 50 characters" do
      message = FactoryGirl.create :validmessage
      message.valid?
      expect(message.errors).to(have_key(:content))
    end
  end

end
