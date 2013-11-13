namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(
    name:   "John",
    surname:"Doe",
    email:  "jdoe@gmail.com",
    age: 42,
    login: "Fredo",
    password: "foobar", 
    password_confirmation: "foobar"
    ) 
    99.times do |n|
      name  = Faker::Name.first_name
      surname = Faker::Name.last_name
      email = "example-#{n+1}@gmail.com"
      age= rand(80) + 10
      login= "#{Faker::Internet.user_name}#{n}"
      password  = "foobar"
      User.create!(name: name,
                   surname: surname,
                   email: email,
                   age: age,
                   login: login,
                   password: password,
                   password_confirmation: password)
    end
  end
end