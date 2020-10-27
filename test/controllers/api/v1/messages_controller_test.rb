class Api::V1::MessagesControllerTest < ActionDispatch::IntegrationTest
  describe '#create' do
    let(:valid_params) { { recipient: '5554443333', content: 'this is a test!!1' } }
    let(:params_missing_content) { valid_params.dup.tap { |p| p[:content] = nil } }
    let(:params_missing_recipient) { valid_params.dup.tap { |p| p[:recipient] = nil } }

    it 'saves a new messages with valid requests' do
      assert_difference -> { Message.count } do
        post api_v1_messages_path(params: { message: valid_params})
      end

      assert_response :success
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
    end
  end
end