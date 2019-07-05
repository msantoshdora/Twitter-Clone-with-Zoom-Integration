class Topic < ApplicationRecord
	has_many:expertizations
	has_many:users, through: :expertizations
end
