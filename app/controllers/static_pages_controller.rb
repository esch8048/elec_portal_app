class StaticPagesController < ApplicationController
skip_before_filter :require_login

  def home
	if current_user
		redirect_to portal_home_url
	end
  end

  def help
  end

  def about
  end
  
  def contact
  end
  
  def blogs_home
	if signed_in?
	    @micropost  = current_user.microposts.build
		  @feed_items = current_user.feed.paginate(page: params[:page])	
	end
  end
  
end
