require 'rails_helper'

RSpec.describe Message, type: :model do

  let(:message) { FactoryGirl.create :message }

  describe "validations" do
    it "requires a valid email address" do
      message = Message.new
      message.valid?
      expect(message.errors).to(have_key(:email))
    end

    it "requires a description presence" do
      attrs = FactoryGirl.attributes_for(:message, content: nil)
      message = Message.create attrs
      message.valid?
      expect(message.errors).to(have_key(:content))
    end

    it "requires a description to be longer than 50 characters" do
      attrs = FactoryGirl.attributes_for(:message, content: "1255")
      message = Message.create attrs
      message.valid?
      expect(message.errors).to(have_key(:content))
    end
  end

end
