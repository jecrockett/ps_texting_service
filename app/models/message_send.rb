class MessageSend < ApplicationRecord
  belongs_to :message
  belongs_to :provider
end
