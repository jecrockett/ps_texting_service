class Api::V1::MessagesController < Api::ApiController
  def create
    @message = Message.new(message_params)

    if @message.save
      if @message.sent?
        render json: @message, status: 201
      else
        error = 'Sorry, something went wrong. Please try again later.'
        render json: { error: error }, status: 500
      end
    else
      render json: { error: @message.errors.full_messages }, status: 422
    end
  rescue StandardError => e
    render json: { error: "#{e}" }, status: 500
  end

  private

  def message_params
    params.require(:message).permit(:content, :recipient)
  end
end
