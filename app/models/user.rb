class User < ActiveRecord::Base
  attr_accessible :age, :email, :login, :name, :surname
end
