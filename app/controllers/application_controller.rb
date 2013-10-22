class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user

	private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	  rescue ActiveRecord::RecordNotFound
		  flash[:notice] = "No current student"
		  @current_user = nil
		  session[:student_id] = nil
		  redirect_to root_url	  
	end
	
	 def admin_required  
    unless current_user && (current_user.permission_level == 1 || current_user.id == 1)  
      redirect_to '/' 
    end 
  end
  def admin_or_owner_required(id)  
    unless current_user.id == id || current_user.permission_level == 1 || current_user.id == 1 
      redirect_to '/' 
    end 
  end
  
  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end