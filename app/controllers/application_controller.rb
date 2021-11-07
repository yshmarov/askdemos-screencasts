class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  def render_turbo_flash
    turbo_stream.update('flash', partial: 'shared/flash')
  end
end
