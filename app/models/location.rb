class Location < ApplicationRecord

  has_many :machines, dependent: :destroy

end
