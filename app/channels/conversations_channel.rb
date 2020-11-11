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
    user = User.find(data["message"])
    check_conversation = current_user.has_conversation_with(user)

    if check_conversation
      new_conversation = check_conversation
    else
      new_conversation = Conversation.create(title: "New conversation by #{current_user.username}")
      Message.create(text: "This is the beginning of your conversation with #{user.username}", conversation: new_conversation, user: current_user)
      Message.create(text: "This is the beginning of your conversation with #{current_user.username}", conversation: new_conversation, user: user)
    end

    self.broadcast_to(current_user, {action: "create_conversation", payload: new_conversation})
  end

  def find_user_by_match(data)
    matches = []

    if data["message"] != ""
      usernames = User.arel_table[:username]
      matches = User.where(usernames.matches("#{data["message"]}%")).select(:id, :username)
    end

    self.broadcast_to(current_user, {action:'find_user_by_match', payload: matches})
  end

  def all_conversations
    conversations = current_user.conversations.uniq

    self.broadcast_to(current_user, {action:'all_conversations', payload: conversations})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
