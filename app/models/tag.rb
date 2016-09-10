class Tag < ApplicationRecord
  has_many :taggingd, dependent: :destroy
  has_many :games, through: :taggings
end
