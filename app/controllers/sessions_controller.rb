class SessionsController < ApplicationController
	
  # Logs a user in
  def create
    user_name = params[:email].downcase
  	user = User.find_by(email: user_name)
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
      call = "http://recruiting-api.nextcapital.com/users/sign_in?email=#{params[:email]}&password=#{params[:password]}"
      url = HTTParty.post(call)
      response = JSON.parse(url.body)
      user.api_token = response["api_token"]
      user.save

  		redirect_to user_path(user)
  	else
  		redirect_to login_url, alert: "Invalid user/password combination"
  	end
  end

  def destroy
    call = "http://recruiting-api.nextcapital.com/users/sign_in?user_id=#{@user.remote_id}&api_token=#{session['api_token']}"
    url = HTTParty.post(call)
    response = JSON.parse(url.body)
    @user.api_token = nil
    @user.save
    
    reset_session
    redirect_to root_url , notice: "Logged out"
  end
end