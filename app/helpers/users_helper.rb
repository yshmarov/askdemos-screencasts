module UsersHelper
  def username(user)
    if user.name?
      user.name
    else
      user.email.split(/@/).first
    end
  end
end
