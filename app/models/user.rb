class User < ActiveRecord::Base
  attr_accessible :age, :email, :login, :name, :surname, :password, :password_confirmation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]{2,3}\z/i
  VALID_LOGIN_REGEX = /\A[a-zA-Z0-9\-._]+\z/i
  VALID_NAME_REGEX = /\A([[:alpha:]'.\-]+( [[:alpha:]'.\-]+)*)?\z/i
  has_secure_password
  
  validates :name     , presence: true, length: {maximum: 50},
          format: {with: VALID_NAME_REGEX}
  validates :email    , presence: true, length: {maximum: 254},
          format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :surname  , presence: true, length: {maximum: 50},
          format: {with: VALID_NAME_REGEX}
  validates :age      , presence: true, numericality: 
          { only_integer: true, greater_than: 0, less_than_or_equal_to: 130 }
  validates :login    , presence: true, length: {maximum: 50},
          format: {with: VALID_LOGIN_REGEX}, uniqueness: {case_sensitive: false}
  validates :password , length: {minimum: 6}
  before_save { self.email = email.downcase }
end