class Message < ApplicationRecord
  belongs_to :inbox
  belongs_to :user

  MIN_BODY = 6
  MAX_BODY = 2000

  validates :body, presence: true
  # validates :body, uniqueness: { scope: :inbox_id }
  validates :body, length: { in: MIN_BODY..MAX_BODY }
end
