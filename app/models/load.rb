class Load < ApplicationRecord
  belongs_to :game
  belongs_to :machine

  has_many :reviews, dependent: :nullify
end
