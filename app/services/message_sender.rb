class MessageSender
  attr_reader :message, :provider, :payload
  def self.send(message)
    new(message).send
  end

  def initialize(message)
    @message = message
    @provider = ProviderLoadBalancer.call
    @headers = { "Content-Type" => "application/json" }
    @payload = {
      to_number: message.recipient,
      message: message.content,
      callback_url: "http://#{ENV['NGROK_HOST_URL']}/api/v1/delivery_status"
    }
  end

  def send(is_retry: false)
    response = Faraday.post(@provider.url, @payload.to_json, @headers)

    if response.status == 200
      json_response = JSON.parse(response.body)
      message.message_sends.create(provider: provider, provider_message_id: json_response['message_id'])
    elsif response.status == 500 && !is_retry
      puts 'Retrying secondary provider...'
      # try other provider -- currently only two
      # consider returning providers in an array sorted by priority instead to avoid hitting db
      @provider = Provider.where.not(id: provider.id).first
      send(is_retry: true)
    else
      raise StandardError, 'Sorry, something went wrong. Please try again later.'
    end
  end

end