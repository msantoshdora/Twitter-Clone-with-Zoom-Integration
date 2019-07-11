class Micropost < ApplicationRecord
  belongs_to :user
  has_one :meeting
  default_scope -> { order(created_at: :desc) }
  #mount_uploader :picture, PictureUploader
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :user_id, presence: true
  validates_acceptance_of :mentor  #It validates that micropost are only for mentors.
  validates :content, presence: true
  #validate :picture_size

  attr_accessor :create_meeting




  private

    # Validates the size of an uploaded picture.
    # def picture_size
    #   if picture.size > 5.megabytes
    #     errors.add(:picture, "should be less than 5MB")
    #   end
    # end

end
