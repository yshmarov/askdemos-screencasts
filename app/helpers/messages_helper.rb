module MessagesHelper
  def status_color(status)
    Message::STATUS_COLORS[status.to_sym]
  end

  def upvote_label(message, user)
    if user.voted_up_on? message, vote_scope: 'like'
      'UN-vote'
    else
      'UP-vote'
    end
  end

  def downvote_label(message, user)
    if user.voted_down_on? message, vote_scope: 'like'
      'UN-vote'
    else
      'DOWN-vote'
    end
  end
end
