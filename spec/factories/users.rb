FactoryBot.define do
  first_name = Faker::Name.first_name
  last_initial = Faker::Name.last_name[0]
  
  factory :user do
    sequence(:email) { |n| "#{first_name}#{last_initial}#{n}@example#{n}.com" }
    first_name { first_name }
    last_initial { last_initial }
    password { "password" }
  end
end
