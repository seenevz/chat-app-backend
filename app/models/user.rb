class User < ApplicationRecord
  has_many :messages
  has_many :conversations, through: :messages

  has_secure_password

  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  def conversations
    self.messages.reload.map(&:conversation).uniq
  end

  def has_conversation_with(user)
    self.conversations.find{|c| c.users.uniq.include?(user)}
  end

end
