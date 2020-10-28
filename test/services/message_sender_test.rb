require 'test_helper'

class MessageSenderTest < ActiveSupport::TestCase
  describe '#send' do
    let(:sender) { MessageSender.new(create(:message)) }

    let(:success_response) do
      OpenStruct.new(
        status: 200,
        body: { message_id: 'test_message_id' }.to_json
      )
    end

    let(:failed_response) do
      OpenStruct.new(status: 500)
    end

    let!(:primary_provider) { create(:provider) }
    let!(:secondary_provider) { create(:provider) }

    before do
      ProviderLoadBalancer.any_instance.stubs(:primary_provider).returns(primary_provider)
      ProviderLoadBalancer.any_instance.stubs(:secondary_provider).returns(secondary_provider)
    end

    it 'sets a provider and the request payload' do
      msg = sender.message

      assert sender.provider
      assert_equal msg.recipient, sender.payload[:to_number]
      assert_equal msg.content, sender.payload[:message]
    end

    it 'calls to a provider and creates a record with the returned id' do
      Faraday.expects(:post).once.returns(success_response)

      assert_difference -> { MessageSend.count } do
        sender.send
      end

      assert_equal 'test_message_id', MessageSend.last.provider_message_id
    end

    it 'retries send to a different provider if the first one fails' do
      Faraday.expects(:post).twice.returns(failed_response)

      assert_difference -> { MessageSend.count }, 2 do
        sender.send
      end

      sends = MessageSend.last(2)

      assert_equal 2, sends.length
      refute_equal sends.first.provider, sends.last.provider
    end
  end
end