class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    #This method runs every time a client subscribes to a channel, and when you use the broadast/broacast_to method
    
    # @conversation = Conversation.find(params[:conversation_id])
    # byebug
    stream_for current_user
    # stream_from "conversations_channel"

  end
  
  def receive(data)
    # You can use the broadcast/broadcast_to method from both actioncable server and the channel class, represented here by self
    # ActionCable.server.broadcast('conversations_channel', data)
    self.broadcast_to('conversations_channel', data)
  end

  def create_conversation(data)
    
  end

  def find_user(data)
    user = user
  end

  def all_conversations
    
    conversations = current_user.conversations
    self.broadcast_to(current_user, conversations)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
