user = User.find_or_create_by(email: 'test@example.com')
user.first_name = "John"
user.last_initial = "D"
user.password = "password"
user.save
puts "#{user.first_name} #{user.last_initial} created!"

pool = FactoryBot.create(:pool_with_questions_and_choices, user: user)
puts "#{pool.name} created!"
