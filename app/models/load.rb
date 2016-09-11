class Load < ApplicationRecord
  belongs_to :game
  belongs_to :machine

  has_many :reviews, dependent: :nullify

  validates :game_id, presence: true
  validates :machine_id, presence: true
end
