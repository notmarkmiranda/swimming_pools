FactoryBot.define do
  factory :choice do
    question
    sequence(:text) { |n| "answer#{n}" }
  end
end
