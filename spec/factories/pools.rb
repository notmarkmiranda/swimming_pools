FactoryBot.define do
  factory :pool do
    sequence(:name) { |n| "swimming pool #{n}" }
    associated_game { "Superb Owl 55" }
    date { Date.new(2021, 02, 07) }
    multiple_entries { false }
    completed { false }
    user
  end
end
