class Secret < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users_liked, through: :likes, source: :user

# def find like by id and it will take in the current user and based off of that 
#   it will return the like you are looking for 
# selt the id of the like , and match the user secre to it self 
 def find_like_id current_user
    Like.select(:id).where(user: current_user, secret: self)[0].id
  end

end

 