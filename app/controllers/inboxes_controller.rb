class InboxesController < ApplicationController
  before_action :set_inbox, only: %i[show edit update destroy]
  before_action :authorize_inbox, only: %i[edit update destroy]

  def index
    # set_meta_tags title: %w[Inboxes All]
    # set_meta_tags title: "Inboxes"
    set_meta_tags title: controller_name.capitalize
    # @inboxes = Inbox.all
    @q = Inbox.ransack(params[:q])
    @inboxes = @q.result(distinct: true).order(created_at: :desc)
  end

  def show
    set_meta_tags title: @inbox.name
  end

  def new
    set_meta_tags title: "#{action_name.capitalize} #{controller_name.capitalize.singularize}"
    @inbox = Inbox.new
  end

  def edit
    set_meta_tags title: "#{action_name.capitalize} #{controller_name.capitalize.singularize}"
  end

  def create
    @inbox = current_user.inboxes.new(inbox_params)

    respond_to do |format|
      if @inbox.save
        format.html { redirect_to @inbox, notice: 'Inbox was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @inbox.update(inbox_params)
        format.html { redirect_to @inbox, notice: 'Inbox was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inbox.destroy
    respond_to do |format|
      format.html { redirect_to inboxes_url, notice: 'Inbox was successfully destroyed.' }
    end
  end

  private

  def authorize_inbox
    authorize @inbox
  end

  def set_inbox
    @inbox = Inbox.find(params[:id])
  end

  def inbox_params
    params.require(:inbox).permit(:name, :theme_color)
  end
end
