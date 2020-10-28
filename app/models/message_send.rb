class MessageSend < ApplicationRecord
  belongs_to :message
  belongs_to :provider

  validates :status, inclusion: { in: ['delivered', 'failed', 'invalid', 'error'] }, allow_blank: true

  scope :invalid, -> { where(status: 'invalid') }
end
