class Comment < ActiveRecord::Base
  attr_accessible :content, :rating, :recipe_id
  belongs_to :recipe
  belongs_to :user

  validates :recipe_id, presence: true
  validates :user_id, presence: true
end
