class TopicsController < ApplicationController
   #before_action :initialize, only: [:create]
	def index
		@topics = Topic.all
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

	def new
		@topics = Topic.all
		if !(logged_in? && current_user.admin?)
          redirect_to topics_path
        end
	end

	def create
		@topics = Topic.all
		@new_topic = Topic.new(name: params[:topic])
		if  @new_topic.save
			flash[:success] = "Topic added"
			redirect_to topics_path
		elsif params[:topic].empty?
			flash[:danger] = "Topic cannot be Empty!"
			render 'new' 
		else	
			flash[:danger] = "Topic already present!"
			render 'new'
		end
	end
end
