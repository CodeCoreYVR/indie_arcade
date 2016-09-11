class Tagging < ApplicationRecord
  belongs_to :game
  belongs_to :tag

  validates :game_id, presence: true
  validates :tag_id, presence: true
end
