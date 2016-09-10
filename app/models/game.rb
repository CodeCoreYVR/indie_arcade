class Game < ApplicationRecord
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def self.search_by_user(search)
    User.where("company LIKE ?", "%#{search}").includes(:games)
  end
end
