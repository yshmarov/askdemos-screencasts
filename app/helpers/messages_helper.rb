module MessagesHelper

  def status_color(status)
    Message::COLOR_STATUSES[status.to_sym] || 'grey'
  end
end
