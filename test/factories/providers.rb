FactoryBot.define do
  factory :provider do
    sequence(:name) { |n| "Provider #{n}" }
    sequence(:url) { |n| "http://www.thisisanendpoint.com/provider#{n}" }
  end
end