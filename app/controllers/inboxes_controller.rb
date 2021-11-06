class InboxesController < ApplicationController
  before_action :set_inbox, only: %i[show edit update destroy]

  def index
    @inboxes = Inbox.all
  end

  def show; end

  def new
    @inbox = Inbox.new
  end

  def edit; end

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

  def set_inbox
    @inbox = Inbox.find(params[:id])
  end

  def inbox_params
    params.require(:inbox).permit(:name)
  end
end
