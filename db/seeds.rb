# Add a console message so we can see output when the seed file runs
puts "Seeding tables..."

user1 = User.create(
    name: 'Malcolm',
    email: 'malcolm@gmail',
    password: '123',
    username: 'MGX'
)
user2 = User.create(
    name: 'Malcolm1',
    email: 'malcolm@gmail1',
    password: '123',
    username: 'MGX1'
)
user3 = User.create(
    name: 'Malcolm2',
    email: 'malcolm@gmail2',
    password: '123',
    username: 'MGX2'
)
user4 = User.create(
    name: 'Malcolm3',
    email: 'malcolm@gmail3',
    password: '123',
    username: 'MGX3'
)
user5 = User.create(
    name: 'Malcolm4',
    email: 'malcolm@gmail4',
    password: '123',
    username: 'MGX4'
)
user6 = User.create(
    name: 'Malcolm5',
    email: 'malcolm@gmail5',
    password: '123',
    username: 'MGX5'
)


# 6.times do
#     user = User.create(
#         name: Faker::Name.name,
#         email: Faker::Internet.email,
#         password: Faker::Internet.password,
#         username: Faker::Internet.username
#     )
# end

5.times do |i|
    project = Project.create(
        title: Faker::Company.bs,
        project_owner_id: rand(1..6),
        description: Faker::Quote.famous_last_words,
        status: rand(0..3),
        due: Faker::Date.forward(days: 100)
    )
    randomized_users = (1..6).to_a.shuffle
    rand(1..5).times do |j|
        if project.project_owner_id!=randomized_users[j]
        Job.create(
        user_id: randomized_users[j],
        project_id: i+1
        )
        end
    end
end

puts "Done seeding!"