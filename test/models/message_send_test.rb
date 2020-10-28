require 'test_helper'

class MessageSendTest < ActiveSupport::TestCase
  describe 'MessageSend validity' do
    let(:provider) { build_stubbed(:provider) }
    let(:msg) { build_stubbed(:message) }

    it 'is valid with just a message and a provider' do
      assert build(:message_send, message: msg, provider: provider).valid?
    end

    it 'is invalid without a message' do
      refute build(:message_send, message: nil, provider: provider).valid?
    end

    it 'is invalid without content' do
      refute build(:message_send, message: msg, provider: nil).valid?
    end

    describe 'status' do
      it 'can be "delivered", "failed", "invalid", "error", or blank' do
        assert(
          ['delivered', 'failed', 'invalid', 'error', nil].all? do |status|
            build(:message_send, status: status).valid?
          end
        )
      end

      it 'cannot be anything besides defined statuses' do
        assert(
          ['test', :test, 123, {}].none? do |status|
            build(:message_send, status: status).valid?
          end
        )
      end
    end
  end
end
