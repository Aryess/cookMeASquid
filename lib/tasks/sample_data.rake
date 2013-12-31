namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(
      name:   "John",
      surname:"Doe",
      email:  "jdoe@gmail.com",
      age: 42,
      login: "Fredo",
      password: "foobar",
      password_confirmation: "foobar"
      )
    admin.toggle!(:admin)
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
    100.times do |n|
      name  = Faker::Commerce.product_name
      short = Faker::Lorem.paragraph[0..199]
      detail= Faker::Lorem.paragraph(5, true, 3)
      rand(10).times do |i|
        detail += "\n\n"
        detail += Faker::Lorem.paragraph
      end
      difficulty= rand(4)+1
      serving = rand(3)+1
      Recipe.create!(short: short,
                   detail: detail,
                   difficulty: difficulty,
                   serving: serving,
                   name: name
                   )
    end
    Recipe.all.each do |r|
      5.times do |i|
        begin
          content = Faker::Lorem.sentence
          rating = rand(3) + 1
          user = User.find(1+rand(User.count))
          user.comments.create!(content: content,
                                rating: rating,
                                recipe_id: r.id)
        rescue
          #Breaking monotony in comments number ;)
        end
      end
    end
  end
end