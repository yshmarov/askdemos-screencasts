module MessagesHelper
  def status_color(status)
    Message::STATUS_COLORS[status.to_sym]
  end

  def upvote_label(message, user)
    vote_message = if user.voted_up_on? message, vote_scope: 'like'
                     'UN-vote'
                   else
                     'UP-vote'
                   end
    tag.span do
      "#{message.cached_scoped_like_votes_up} #{vote_message}"
    end
  end

  def downvote_label(message, user)
    vote_message = if user.voted_down_on? message, vote_scope: 'like'
                     'UN-vote'
                   else
                     'DOWN-vote'
                   end
    tag.span do
      "#{message.cached_scoped_like_votes_down} #{vote_message}"
    end
  end
end
