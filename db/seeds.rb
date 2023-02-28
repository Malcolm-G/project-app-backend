# Add a console message so we can see output when the seed file runs
puts "Seeding tables..."

6.times do
    user = User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: Faker::Internet.password
    )
end

5.times do |i|
    project = Project.create(
        title: Faker::Commerce.product_name,
        project_owner_id: rand(1..6),
        description: Faker::Quote.famous_last_words,
        status: rand(1..4),
        due: Faker::Date.forward(days: 100)
    )
    randomized_users = (1..6).to_a.shuffle
    rand(1..5).times do |j|
        Job.create(
        user_id: randomized_users[j],
        project_id: i+1
        )
    end
end

puts "Done seeding!"