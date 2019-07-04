class Relationship < ApplicationRecord
  before_save :validate_followed
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true


  def validate_followed
  	#add validation to check if the followed user is mentor or not
  	user = User.find(self.followed_id)
  	user.mentor
  	debugger
  end
end
