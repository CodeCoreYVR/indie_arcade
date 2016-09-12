class Tagging < ApplicationRecord
  belongs_to :game
  belongs_to :tag
  
  validates :tag_id, uniqueness: { scope: :game_id }
end
