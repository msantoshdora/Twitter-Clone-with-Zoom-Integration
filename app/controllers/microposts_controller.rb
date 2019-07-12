class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy


  	def create

    	@micropost = current_user.microposts.build(micropost_params)
      
       if !params[:meeting_created].nil?
                   zoom_obj = Zoom.new
                   email = current_user.email
                   meeting_title = params[:meeting_title]
                   meeting_starttime = params[:meeting_starttime]

                   zoom_url = zoom_obj.create_meeting(email,meeting_title,meeting_starttime)
                  # userId,title,time
                  # zoom_url = auto_link(zoom_url, :urls) 
                   
                  
       end

      
    	if @micropost.save
          if !params[:meeting_created].nil?
              @meeting = @micropost.build_meeting(title:meeting_title, date:meeting_starttime,join_url:zoom_url)
              @meeting.save
          end
      		flash[:success] = "Post created!"
      		redirect_to root_url
    	else
  		  @feed_items = current_user.feed.paginate(page: params[:page])
  		  render 'static_pages/home'
    	end
  	end

  	def destroy
  		 @micropost.destroy
	    flash[:success] = "Post deleted"
    	redirect_to request.referrer || root_url
  	end


  	private

    def micropost_params
      params.require(:micropost).permit(:content, :attachment)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
