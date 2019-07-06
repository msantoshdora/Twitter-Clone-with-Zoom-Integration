class TopicsController < ApplicationController

	def index
		@topics = Topic.all
		#debugger
		@user = current_user
	end

	def show
		#if logged_in?
		 @t = Topic.find(params[:id])
		#debugger
		 @all_user = @t.users
		 @all_topics = Topic.all
		#else 
		#	flash[:danger] = "Please log in."
		#	redirect_to login_url
		#end

	end
end
