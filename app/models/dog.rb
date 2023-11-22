class Dog < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :bookings
  has_many :reviews
  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
