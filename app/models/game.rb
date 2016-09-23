class Game < ApplicationRecord
  include PgSearch
  pg_search_scope(
    :search_by, lambda do |type, query|
      if type == 'main'
        {
        :against =>{ title: 'A', description: 'B'},
        using: {
          tsearch:{dictionary: "english",
                   prefix: true,
                   any_word: true}
        },
        :query => query
      }
      elsif type == 'user'
        {
        :associated_against => {:user => :company},
        using: {
          tsearch: {prefix: true,
                    any_word: true}
        },
        :query => query
      }
      else {
        associated_against: {:tags => :id},
        :query => query
        }
      end
    end
  )

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
  validates :aasm_state, presence: true
  validates :description, presence: true

  mount_uploader :picture, PictureUploader

  scope :user_data_subset, -> (admin,dev,dev_id){
  admin ? all : dev ? where(user_id: dev_id) :
  where(aasm_state: ["Released to arcade","Not released"])}

  def set_defaults
    self.aasm_state ||= "Game under review"
  end

  def self.search(search)
    Game.where("title ILIKE ?", "%#{search}%")
  end

  def self.approved
    Game.where("status_id = ? OR status_id = ?", "1", "2" )
  end

  # Usage example: @game.average_score_for :fun
  def average_score_for( attribute )
    reviews.average( attribute ).round(2) * 20
  end
end
