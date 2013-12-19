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

  factory :recipe do
    name    "Recipe nb 1"
    short   "Blahblahblahblah"
    detail  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eget interdum augue. Duis cursus, lacus nec egestas hendrerit, nibh nibh vestibulum libero, a facilisis tellus nisi ut metus. Integer ac suscipit sem. Morbi magna erat, vulputate in massa ut, condimentum dapibus odio. Phasellus aliquet risus nunc, nec ornare enim fringilla vitae. Cras semper elit eu luctus molestie. Donec bibendum fermentum eros. Vivamus sodales tristique elit at accumsan. Sed in tellus euismod, accumsan purus pulvinar, suscipit sapien. Etiam vitae eros ligula. Etiam posuere neque ac scelerisque tempor. Phasellus gravida, ligula a cursus adipiscing, lectus lorem euismod enim, vel commodo nisl sem at arcu.

Donec auctor luctus porttitor. Nulla facilisi. Ut a eros felis. Donec mauris ipsum, mattis a aliquet eu, imperdiet ac ante. Duis placerat tellus sit amet dui dictum, interdum viverra dolor mattis. Vestibulum elementum mauris ligula, eget porta sapien pretium at. Donec dictum magna vel purus consequat, eget tincidunt lacus eleifend. Nullam dictum, lacus nec placerat vehicula, risus neque varius metus, faucibus accumsan sapien libero eget mauris. "
    difficulty  4
    serving     3
  end
end