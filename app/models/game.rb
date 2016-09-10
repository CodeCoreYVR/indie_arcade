class Game < ApplicationRecord
  belongs_to :user
  belongs_to :status

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :loads, dependent: :nullify

  has_many :reviews, dependent: :nullify
  has_many :load_reviews, through: :loads
end
