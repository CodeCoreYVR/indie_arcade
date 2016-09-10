class User < ApplicationRecord
  has_many :games, dependent: :destroy

  def self.search(search)
    User.where("company ILIKE ?", "%#{search}%")
  end
end
