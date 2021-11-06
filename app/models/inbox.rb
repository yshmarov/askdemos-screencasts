class Inbox < ApplicationRecord
  MIN_NAME = 6
  MAX_NAME = 100

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { in: MIN_NAME..MAX_NAME }
end
