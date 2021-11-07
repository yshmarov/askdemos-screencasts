module MessagesHelper
  def status_color(status)
    case status
    when "incoming"
      "blue"
    when "todo"
      "orange"
    when "done"
      "green"
    when "spam"
      "red"
    end
  end
end
