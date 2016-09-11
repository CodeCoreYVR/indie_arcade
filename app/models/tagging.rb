class Tagging < ApplicationRecord
  belongs_to :game
  belongs_to :tag

  validates :name, presence: true
end
