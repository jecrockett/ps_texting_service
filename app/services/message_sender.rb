class MessageSender
  attr_reader :message, :provider, :payload, :headers

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
      callback_url: "https://#{callback_domain}/api/v1/delivery_status"
    }
  end

  def send(is_retry: false)
    return unless provider

    response = Faraday.post(provider.url, payload.to_json, headers)

    if response.status == 200
      json_response = JSON.parse(response.body)
      message.message_sends.create(provider: provider, provider_message_id: json_response['message_id'])
    else
      record_send_error!
      retry_send if !is_retry
    end
  end

  private

  def record_send_error!
    message.message_sends.create(provider: provider, status: 'error')
  end

  def retry_send
    puts 'Retrying secondary provider...' unless Rails.env.test?
    # NOTE: consider returning two providers in an array sorted by priority instead to avoid hitting db
    @provider = Provider.where.not(id: provider.id).first
    send(is_retry: true)
  end

  def callback_domain
    Rails.env.production? ? ENV['APP_DOMAIN'] : ENV['NGROK_DOMAIN']
  end
end