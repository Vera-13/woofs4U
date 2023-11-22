class Dog < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :bookings

  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
end
