class Machine < ApplicationRecord
  belongs_to :location

  has_many :loads, dependent: :nullify

  validates :location_id, presence: true
end
