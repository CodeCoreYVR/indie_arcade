class Message < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, format: VALID_EMAIL_REGEX
  validates :content, presence: true, length: {minimum: 50}

end
