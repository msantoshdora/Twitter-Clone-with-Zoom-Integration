class ExpertizationsController < ApplicationController
  before_action :logged_in_user

  def create
  	topic = Topic.find(params[:topic_id])
  	current_user.addTopic(topic)
  	redirect_to current_user   #check this lines if it really works or where it is redirecting.
  end

  def destroy
  	#check in relationships_controller for what to write
  end
end
