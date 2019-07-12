class Meeting < ApplicationRecord
  belongs_to :micropost
  validates :title, presence: true, length: {maximum: 50}
  validates :date, presence: true
  validates :join_url, presence: true
end
