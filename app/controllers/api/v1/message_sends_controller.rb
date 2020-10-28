class Api::V1::MessageSendsController < Api::ApiController
  def delivery_status
    message_send = MessageSend.find_by(provider_message_id: params[:message_id])
    message_send.update!(status: params[:status], status_updated_at: Time.now)
  end
end
