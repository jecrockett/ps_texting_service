FactoryBot.define do
  factory :message do
    recipient { "1231231234" }
    content { 'Hello World' }
  end
end