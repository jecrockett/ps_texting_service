class Message < ApplicationRecord
  has_many :message_sends
  has_many :providers, through: :message_sends

  validates :content, presence: true
  validates :recipient, presence: true

  after_create :send_message

  def send_message
    MessageSender.send(self)
  end
end
