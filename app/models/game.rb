class Game < ApplicationRecord
  belongs_to :user
  belongs_to :status

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :loads, dependent: :nullify

  has_many :reviews, dependent: :nullify
  has_many :load_reviews, through: :loads

  MAXIMUM_CPU = 5000
  MAXIMUM_GPU = 4500
  MAXIMUM_RAM = 4000
  MAXIMUM_HD_SPACE = 6000

  after_initialize :set_defaults

  validates :title, presence: true,
                    uniqueness: {case_sensitive: false}
  validates :user_id, presence: true
  validates :status_id, presence: true
  validates :description, presence: true

  mount_uploader :picture, PictureUploader

  scope :with_company_containing, -> (user_name) {where(user_id: User.search(user_name))}
  def set_defaults
    self.status_id ||= 3
  end

  def self.search(search)
    Game.where("title ILIKE ?", "%#{search}%")
  end

  def self.approved
    Game.where("status_id = ? OR status_id = ?", "1", "2" )
  end

end
