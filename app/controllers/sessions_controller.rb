class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username], 
      params[:user][:password]
    )
    if @user.nil?
      flash.now[:errors] = [ "Invalid credentials!" ]
      render :new
    else
      flash[:notices] = [ "Welcome back #{@user.username}" ]
      login_user!(@user)
      redirect_to :root
    end
  end
  
  def destroy
    flash[:notcies] = [ "Goodbye" ]
    logout_user!
    redirect_to login_url
  end
end
