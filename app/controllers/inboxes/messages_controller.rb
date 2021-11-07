module Inboxes
  class MessagesController < ApplicationController
    before_action :set_inbox

    def upvote
      @message = @inbox.messages.find(params[:id])
      flash[:notice] = 'voted!'
      if current_user.voted_up_on? @message
        @message.downvote_from current_user
      elsif current_user.voted_down_on? @message
        @message.liked_by current_user
      else
        @message.liked_by current_user
      end
      redirect_to @inbox
    end

    def new
      @message = @inbox.messages.new
    end

    def create
      @message = @inbox.messages.new(message_params)

      respond_to do |format|
        if @message.save
          format.turbo_stream do
            render turbo_stream: 
             turbo_stream.update('new_message',
                                 partial: 'inboxes/messages/form',
                                 locals: { message: Message.new })
          end
          format.html { redirect_to @inbox, notice: 'Message was successfully created.' }

        else
          format.turbo_stream do
            render turbo_stream:
              turbo_stream.update('new_message',
                                  partial: 'inboxes/messages/form',
                                  locals: { message: @message })
          format.html { render :new, status: :unprocessable_entity }
          end
        end
      end
    end

    def destroy
      @message = @inbox.messages.find(params[:id])
      @message.destroy
      respond_to do |format|
        format.html { redirect_to @inbox, notice: 'Message was successfully destroyed.' }
      end
    end

    private

    def set_inbox
      @inbox = Inbox.find(params[:inbox_id])
    end

    def message_params
      params.require(:message).permit(:body).merge(user: current_user)
    end
  end
end
