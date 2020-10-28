require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  describe 'Message validity' do
    it 'is valid with a recipient and content' do
      assert build(:message, recipient:'1231231234', content: 'This is some content').valid?
    end

    it 'is invalid without a recipient' do
      refute build(:message, recipient: nil, content: 'This is some content').valid?
    end

    it 'is invalid without content' do
      refute build(:message, recipient:'1231231234', content: nil).valid?
    end

    describe 'custom validation #verify_recipient' do
      let(:invalid_send) { create(:message_send, status: 'invalid') }

      it 'is invalid if the intended recipient has invalid send attempts' do
        refute build(:message, recipient: invalid_send.message.recipient).valid?
      end
    end
  end

  describe '#send_message' do
    it 'calls the message sender after creation' do
      MessageSender.expects(:send).once
      create(:message)
    end
  end

  describe '#sent?' do
    let(:sent) { create(:message_send, provider_message_id: 'test').message }
    let(:unsent) { create(:message_send, provider_message_id: nil).message }

    it 'returns true if any message_sends have a provider_message_id' do
      assert sent.sent?
      refute unsent.sent?
    end
  end
end
