class User < ApplicationRecord
  has_many :messages
  has_many :conversations, through: :messages

  has_secure_password

  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  def conversations
<<<<<<< HEAD
    self.messages.reload.map(&:conversation).uniq
=======
    self.messages.map(&:conversation).uniq
>>>>>>> 71a9950ddc584a313c36f1354b9ac48841ced2b8
  end

  def has_conversation_with(user)
    self.conversations.find{|c| c.users.uniq.include?(user)}
  end

end
