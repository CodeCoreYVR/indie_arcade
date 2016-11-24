class Game < ApplicationRecord
  include AASM
  STATE_APPROVE = 'approve'.freeze
  STATE_REJECT = 'reject'.freeze

  aasm whine_transitions: false do
    state :under_review, initial: true
    state :rejected
    state :unreleased
    state :released
    state :incompatible

    event :approve do
      transitions from: [:under_review, :rejected,
                         :incompatible], to: :unreleased
    end

    event :reject do
      transitions from: [:under_review, :unreleased,
                         :released, :incompatible], to: :rejected
    end
  end

  include PgSearch
  pg_search_scope(
    :search_by, lambda do |type, query|
      if type == 'main'
        {
          against: { title: 'A' },
          using: {
            tsearch: { dictionary: 'english',
                       prefix: true,
                       any_word: true }
          },
          query: query
        }
      elsif type == 'user'
        {
          associated_against: { user: :company },
          using: {
            tsearch: { prefix: true,
                       any_word: true }
          },
          query: query
        }
      elsif type == 'state'

        { against: { aasm_state: 'A' },
          query: query }
      else
        {
          associated_against: { tags: :id },
          query: query
        }
      end
    end
  )

  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :loads, dependent: :nullify

  has_many :reviews, dependent: :nullify
  has_many :load_reviews, through: :loads

  MAXIMUM_CPU = 5000
  MAXIMUM_GPU = 4500
  MAXIMUM_RAM = 4000
  MAXIMUM_HD_SPACE = 6000

  validates :title, presence: true,
                    uniqueness: { case_sensitive: false }
  validates :user_id, presence: true
  validates :aasm_state, presence: true
  validates :description, presence: true

  mount_uploaders :pictures, PictureUploader
  mount_uploader :attachment, AttachmentUploader

  scope(:user_data_subset, lambda do |admin, dev, dev_id|
    if admin == true
      all
    elsif dev == true
      where('user_id=? OR aasm_state=? or aasm_state=?',
            dev_id, 'released', 'unreleased')
    else
      where(aasm_state: %w(released unreleased))
    end
  end)

  delegate :company, to: :user, prefix: true

  # Usage example: @game.average_score_for :fun
  def average_score_for(attribute)
    reviews.average(attribute).round(2) * 20
  end

  def reviews_count
    reviews.count
  end
end
