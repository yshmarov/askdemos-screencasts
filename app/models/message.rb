class Message < ApplicationRecord
  belongs_to :inbox, counter_cache: true
  belongs_to :user

  STATUS_COLORS = { incoming: 'grey', todo: 'orange', done: 'green', spam: 'red' }

  MIN_BODY = 6
  MAX_BODY = 2000

  validates :body, presence: true
  # validates :body, uniqueness: { scope: :inbox_id }
  validates :body, length: { in: MIN_BODY..MAX_BODY }

  acts_as_votable

  enum status: {
    incoming: 'incoming',
    todo: 'todo',
    done: 'done',
    spam: 'spam'
  }

  def upvote!(user)
    if user.voted_up_on? self, vote_scope: 'like'
      unvote_by user, vote_scope: 'like'
    else
      upvote_by user, vote_scope: 'like'
    end
  end
end
