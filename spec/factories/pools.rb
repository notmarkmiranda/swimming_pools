FactoryBot.define do
  factory :pool do
    sequence(:name) { |n| "swimming pool #{n}" }
    associated_game { "Superb Owl 55" }
    date { Date.new(2021, 02, 07) }
    multiple_entries { false }
    completed { false }
    user

    factory :pool_with_questions_and_choices do
      after(:create) do |pool, evaluator|
        create(:question, pool: pool, text: "Who will win SB 55?").tap do |question|
          create(:choice, question: question, text: "KC")
          create(:choice, question: question, text: "TB")
        end

        create(:question, pool: pool, text: "Who will with the 2021 World Series?").tap do |question|
          create(:choice, question: question, text: "LA")
          create(:choice, question: question, text: "NY")
        end
      end
    end
  end
end
