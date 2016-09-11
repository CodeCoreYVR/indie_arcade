class Machine < ApplicationRecord
  belongs_to :location

  has_many :loads, dependent: :nullify
end
