class Status < ApplicationRecord
  has_many :games

  validates :name, presence: true
end
