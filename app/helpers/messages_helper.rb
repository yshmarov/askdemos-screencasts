module MessagesHelper
  def status_color(status)
    Message::STATUS_COLORS[status.to_sym]
  end
end
