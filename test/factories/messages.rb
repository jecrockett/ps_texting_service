FactoryBot.define do
  factory :message do
    recipient { "1231231234" }
    content { 'Hello World' }

    _skip_sending_message { true }

    trait :send_message do
      _skip_sending_message { false }
    end
  end
end