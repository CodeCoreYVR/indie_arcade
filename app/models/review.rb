class Review < ApplicationRecord
  belongs_to :load

  validates :load_id, presence: true
  validates :game_id, presence: true
end
