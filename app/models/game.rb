class Game < ApplicationRecord
  belongs_to :user
  belongs_to :status

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :loads, dependent: :nullify

  has_many :reviews, dependent: :nullify
  has_many :load_reviews, through: :loads

  mount_uploader :picture, PictureUploader


  scope :with_company_containing, -> (user_name) {where(user_id: User.search(user_name))}

  def self.search(search)
    Game.where("title ILIKE ?", "%#{search}%")
  end
end
