FactoryBot.define do
  factory :user do
    sequence(:email_address)  { |n| "#{n}@google.com" }
    password                  { "my password" }
  end
end
