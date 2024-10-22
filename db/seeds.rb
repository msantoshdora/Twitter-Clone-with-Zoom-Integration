User.create!(name:  "Admin",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             mentor: true)


99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  if n<5
    mentor = true
  else
    mentor = false
  end
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               mentor: mentor)
end

User.create!(name:  "Last User",
             email: "last@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: false,
             mentor: false)




10.times do |n|
  name = Faker::Name.first_name
  Topic.create!(name:name)
end

users = User.order(:created_at).take(6)
5.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end


# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }


# Expertizations
users = User.all
user = users.first
mentors = users[1..6]
topicss = Topic.all
topicss.each { |m| user.add_topic(m)}
