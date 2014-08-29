class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def logged_in?
    !!current_user
  end
  
  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def logout_user!
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
  end
  
  def require_login!
    if current_user.nil?
      flash[:errors] = [ "You must be logged in to do that!" ]
      redirect_to login_url
    end
  end
  
  def require_moderator! sub_id = params[:id]
    @sub = Sub.find(sub_id)
    
    if current_user != @sub.moderator
      flash[:errors] = [ "Permission denied!" ]
      redirect_to sub_url(@sub)
    end 
  end
  
end
