class Inbox < ApplicationRecord
  belongs_to :user
  has_many :messages, -> { order(created_at: :desc) }, dependent: :destroy, inverse_of: :inbox

  MIN_NAME = 6
  MAX_NAME = 100

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { in: MIN_NAME..MAX_NAME }

  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]
end
