class Dog < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :global_search,
  against: [ :name, :user_id ],
  associated_against: {
    user_id: [ :first_name, :last_name ]
  },
  using: {
    tsearch: { prefix: true }
  }
  has_one_attached :photo
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
