class Api::V1::MessagesController < Api::ApiController

  #temporary for debugging
  def index
    @messages = Message.all
    render json: @messages
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: 201
    else
      render json: @message.errors.full_messages, status: 422
    end
  rescue StandardError => e
    render json: { error: "#{e}" }, status: 500
  end

  private

  def message_params
    params.require(:message).permit(:content, :recipient)
  end
end
