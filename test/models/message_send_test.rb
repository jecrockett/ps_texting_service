require 'test_helper'

class MessageSendTest < ActiveSupport::TestCase
  describe 'MessageSend validity' do
    let(:provider) { build_stubbed(:provider) }
    let(:msg) { build_stubbed(:message) }

    it 'is valid with a message and a provider' do
      assert build(:message_send, message: msg, provider: provider).valid?
    end

    it 'is invalid without a message' do
      refute build(:message_send, message: nil, provider: provider).valid?
    end

    it 'is invalid without content' do
      refute build(:message_send, message: msg, provider: nil).valid?
    end
  end
end
