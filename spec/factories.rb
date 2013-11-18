FactoryGirl.define do
  factory :user do
    name      "Alfred"
    surname   "Dupond"
    sequence(:email) { |n| "person_#{n}@example.com"}
    age       34
    sequence(:login)  { |n| "login#{n}" }
    password  "foobar"
    password_confirmation "foobar"

    factory :admin do
    	admin true
    end
  end
end