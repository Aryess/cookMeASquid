FactoryGirl.define do
  factory :user do
    name      "Alfred"
    surname   "Dupond"
    email     "alfred.dupond@gmail.com"
    age       34
    login     "Fredo"
    password  "foobar"
    password_confirmation "foobar"
  end
end