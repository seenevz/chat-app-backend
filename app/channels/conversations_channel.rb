class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    #This method runs every time a client subscribes to a channel, and when you use the broadast/broacast_to method
    current_user = User.find(params[:user_id])
    # @conversation = Conversation.find(params[:conversation_id])
    byebug
    stream_for current_user
    # stream_from "conversations_channel"

  end
  
  def receive(data)
    # You can use the broadcast/broadcast_to method from bothe actioncable server and the channel class, represented he by self
    # ActionCable.server.broadcast('conversations_channel', data)
    byebug
    self.broadcast_to('conversations_channel', data)
  end

  def all_conversations
    conversations = current_user.conversations
    byebug
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
