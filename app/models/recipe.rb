class Recipe < ActiveRecord::Base
  attr_accessible :detail, :difficulty, :short, :name, :serving

  validates :short	,presence: true, length: {minimum: 6, maximum: 200}
  validates :name	,presence: true, length: {minimum: 5, maximum: 35}
  validates :serving,presence: true, numericality:
          { only_integer: true, greater_than_or_equal_to: 0}
  validates :detail	,presence: true, length: {minimum: 50}
  validates :difficulty, presence:true, numericality:
          { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  has_many :comments
end
