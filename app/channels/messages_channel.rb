class MessagesChannel < ApplicationCable::Channel
  def subscribed
    #This method runs every time a client subscribes to a channel, and when you use the broadast/broacast_to method
    
    @conversation = Conversation.find(params[:conversation])
    # byebug
    stream_for @conversation
    stream_for current_user
    # stream_from "conversations_channel"

  end
  
  def receive(data)
    # You can use the broadcast/broadcast_to method from both actioncable server and the channel class, represented here by self
    # ActionCable.server.broadcast('conversations_channel', data)
    self.broadcast_to('conversations_channel', data)
  end

  def create_message(data)
    new_message = Message.new(text: data["message"], conversation: @conversation, user: current_user)
    if new_message.save
      self.broadcast_to(@conversation, [new_message])
    else
      self.broadcast_to(@conversation, {error: "Couldn't save message"})
    end
  end
  
  def all_messages
    messages = @conversation.messages
    self.broadcast_to(current_user, messages)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
