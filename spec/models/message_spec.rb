require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "validations" do
    it "requires a valid email address" do
      message = Message.new
      message.valid?
      expect(message.errors).to(have_key(:email))
    end

    it "requires a description presence" do
      message = Message.new({email: "asdf@asdf.com", content: ""})
      message.valid?
      expect(message.errors).to(have_key(:content))
    end

    it "requires a description to be longer than 50 characters" do
      message = Message.new({email: "asdf@asdf.com", content: "aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeee"})
      message.valid?
      expect(message.errors).to(have_key(:content))
    end
  end

end
