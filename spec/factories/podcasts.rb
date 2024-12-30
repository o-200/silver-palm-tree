FactoryBot.define do
  factory :podcast do
    sequence(:title)  { |n| "My Podcast #{n}" }
    description       { "This is a description of my podcast." }
  end
end
