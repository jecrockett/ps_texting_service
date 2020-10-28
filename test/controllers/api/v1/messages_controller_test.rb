class Api::V1::MessagesControllerTest < ActionDispatch::IntegrationTest
  describe '#create' do
    let(:valid_params) { { recipient: '5554443333', content: 'this is a test!!1' } }
    let(:params_missing_content) { valid_params.dup.tap { |p| p[:content] = nil } }
    let(:params_missing_recipient) { valid_params.dup.tap { |p| p[:recipient] = nil } }

    it 'saves a new messages with valid requests' do
      MessageSender.expects(:send).returns(true)
      Message.any_instance.expects(:sent?).returns(true)

      assert_difference -> { Message.count } do
        post api_v1_messages_path(params: { message: valid_params })
      end

      assert_response :success
    end

    it 'returns error to the client if the message is unable to be delivered' do
      Message.any_instance.expects(:sent?).returns(false)

      # we still successfully save the message for reporting
      assert_difference -> { Message.count } do
        post api_v1_messages_path(params: { message: valid_params })
      end

      assert_response :internal_server_error
    end

    describe 'error handling' do
      it 'returns error for missing recipient' do
        assert_no_difference -> { Message.count } do
          post api_v1_messages_path(params: { message: params_missing_recipient })
        end

        assert_response :unprocessable_entity
        assert_includes response.body, "Recipient can't be blank"
      end

      it 'returns error for missing content' do
        assert_no_difference -> { Message.count } do
          post api_v1_messages_path(params: { message: params_missing_content })
        end

        assert_response :unprocessable_entity
        assert_includes response.body, "Content can't be blank"
      end

      it 'catches standard errors' do
        MessageSender.expects(:send).returns(StandardError)
        post api_v1_messages_path(params: { message: valid_params })
        assert_response :internal_server_error
      end
    end
  end
end