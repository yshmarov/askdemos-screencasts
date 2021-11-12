class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_meta, only: %i[pricing privacy terms]

  def landing_page; end

  def pricing; end

  def privacy; end

  def terms; end

  private

  def set_meta
    set_meta_tags title: action_name.capitalize
  end
end
