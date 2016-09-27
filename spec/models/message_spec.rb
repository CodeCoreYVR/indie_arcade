require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "validations" do
    let(:message){FactoryGirl.create(:message)}

    it "requires a valid email address" do
      message.email = ""
      message.save
      expect(message.errors).to(have_key(:email))
    end

    it "requires a description presence" do
      message.content = ""
      message.valid?
      expect(message.errors).to(have_key(:content))
    end

    it "requires a description to be longer than 50 characters" do
      message.content = "aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeee"
      message.valid?
      expect(message.errors).to(have_key(:content))
    end
  end

end
