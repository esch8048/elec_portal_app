class SessionsController < ApplicationController
skip_before_filter :require_login

  def new
	 if current_user
		redirect_to logged_in_path
	 end  
  end
  
  	def logged_in
	end
  
  def current_user
	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    user == current_user
  end
  
	def create
	  user = User.authenticate(params[:email], params[:password])
	  if user
		old_points = user.points
		user.update_attributes(:points => old_points+1)	  
		session[:user_id] = user.id
		redirect_to portal_home_url
	  else
		flash.now[:alert] = "Invalid email or password"
		render "new"
	  end
	end

	def destroy
	  session[:user_id] = nil
	  redirect_to root_url, :notice => "Logged out!"
	end
	
end


  