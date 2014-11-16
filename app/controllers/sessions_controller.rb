class SessionsController < ApplicationController
	
  # Logs a user in
  def create
    user_name = params[:email].downcase
  	user = User.find_by(email: user_name)
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to user_path(user)
  	else
  		redirect_to login_url, alert: "Invalid user/password combination"
  	end
  end

  def destroy
    reset_session
    redirect_to root_url , notice: "Logged out"
  end
end