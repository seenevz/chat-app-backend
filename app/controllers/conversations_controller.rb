class ConversationsController < ApplicationController

  def create
    # byebug
    conversation = Conversation.create(conversation_params)
    ActionCable.server.broadcast('conversations_channel', conversation)
  end

  private

  def conversation_params
    params.require(:conversation).permit(:title)
  end
end
