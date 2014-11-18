class SessionsController < ApplicationController
	
  
  def create
    # attempt to log in
    options = { query: {email: params['email'], password: params['password']}}     
    call = 'http://recruiting-api.nextcapital.com/users/sign_in'
    url = HTTParty.post(call, options)
    response = JSON.parse(url.body)
    if response.has_key?("error")
      redirect_to login_url, alert: response["error"] and return
    else
      puts "SETTING VALUES"
      puts response["api_token"]
      puts response["id"]
      puts response["email"]
      session[:api_token] = response["api_token"]
      session[:id] = response["id"]
      session[:email] = response["email"]
    end

    redirect_to '/users'  
  end

  def destroy
    options = { query: {user_id: session[:user_id], api_token: session[":api_token"]}}     
    call = 'http://recruiting-api.nextcapital.com/users/sign_out'
    url = HTTParty.delete(call, options)
    response = JSON.parse(url.body)
    
    notice_text = "Logged out"
    if response.has_key?("error")
      notice_text = response["error"]
    end if

    reset_session
    redirect_to root_url , notice: notice_text
  end
end


#     "id": 560,
#     "email": "consumer@example.com",
#     "api_token": "GsJZU9VZ83MCzgaMJxxt",
#     "todos": []
# }