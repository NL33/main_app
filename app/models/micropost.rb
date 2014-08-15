class Micropost < ActiveRecord::Base
  belongs_to :user  #this means a micropost belongs to a user
  default_scope -> { order('created_at DESC') } #sets the order of the posts to descending
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
end
