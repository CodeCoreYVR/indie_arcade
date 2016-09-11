class Location < ApplicationRecord

  has_many :machines, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true
end
