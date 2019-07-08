class Topic < ApplicationRecord
	has_many:expertizations
	has_many:users, through: :expertizations
	validates_acceptance_of :admin  #It validates that micropost are only for mentors.
	validates :name, presence: true, length: {maximum: 10},
									uniqueness: { case_sensitive: false }

end
