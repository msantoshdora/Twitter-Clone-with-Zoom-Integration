module TopicsHelper
	def topics
		@all_topics = Topic.all
	end
end
