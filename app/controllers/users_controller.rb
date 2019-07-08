class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :allow_only_mentor, only: [:about, :update_about]

  
  def index
     @users = User.paginate(page: params[:page]) # Here the page parameter comes from paramas[:page], 
     #which is generated by will_paginate(defined in view).
     @mentors = User.where(mentor:true).paginate(page: params[:page]) 
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    #debugger
  end

  def new
  	@user = User.new
  end

  def edit
    @user = User.find(params[:id])
    @topics = Topic.all
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def about
    @user = current_user
    @topics = Topic.all
  end
  
  def update_about
      @user = current_user
      if params[:expert].nil?
        @user.mentor = false
        @user.save
      else
        params[:expert].each do |id|
          topic_id = id.to_i
          if !@user.topics.include?(Topic.find(topic_id))
            @user.add_topic(Topic.find(topic_id))
          end
        end
      end
      redirect_to @user
  end

  def create
  	@user = User.new(user_params)
    #if params[:user][:mentor] == "1"  #check if it is a good way or not. Or adding in permission is good.
     # @user.mentor = true
    #else
     # @user.mentor = false
    #end
    #debugger
  	if @user.save
      log_in @user
      flash[:success] = "Welcome to the SAMPLE App!"
     # render :template => 'users/about_form'
      if !@user.mentor?
  		  redirect_to @user
      else 
        redirect_to about_url
      end
  	else
  		render 'new'
  	end
  end



  def update
    @user = User.find(params[:id])
    user_topics_ids = @user.topics.pluck(:id)
    if params[:expert].present? && user_topics_ids != params[:expert].map(&:to_i)
      debugger
      user_topics_ids.each do |topic_id|
        @user.remove_topic(Topic.find(topic_id))
      end

      params[:expert].each do |id|
        topic_id = id.to_i
        @user.add_topic(Topic.find(topic_id))
      end
    end
    check_mentor =@user.mentor?

    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to (@user.mentor? && !check_mentor && params[:expert].nil?) ? about_url : @user
    else
      render 'edit'
    end
  end

  

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,
                                   :mentor)
    end

     # Before filters

  

  # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

     # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def allow_only_mentor
      redirect_to(root_url) unless logged_in? && current_user.mentor? 
    end

end
