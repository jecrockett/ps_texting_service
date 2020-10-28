class Message < ApplicationRecord
  has_many :message_sends
  has_many :providers, through: :message_sends

  validates :content, presence: true
  validates :recipient, presence: true
  validate :valid_recipient

  after_create :send_message

  def sent?
    message_sends.any? {|send| send.provider_message_id.present? }
  end

  private

  def valid_recipient
    if MessageSend.invalid.joins(:message).where('messages.recipient = ?', self.recipient).any?
      errors.add(:recipient, 'is not valid')
    end
  end

  def send_message
    MessageSender.send(self)
  end
end
