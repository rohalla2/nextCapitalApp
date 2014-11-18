class SessionsController < ApplicationController
	before_action :find_user, only: [:destroy]

  def create
    # attempt to log in
    options = { query: {email: params['email'], password: params['password']}}     
    call = 'http://recruiting-api.nextcapital.com/users/sign_in'
    url = HTTParty.post(call, options)
    response = JSON.parse(url.body)
    if response.has_key?("error")
      redirect_to login_url, notice: response["error"] and return
    else
      session[:api_token] = response["api_token"]
      session[:id] = response["id"]
      session[:email] = response["email"]
    end

    redirect_to '/users'  
  end

  def destroy
    options = { query: {user_id: session[:id], api_token: session[:api_token]}}     
    call = 'http://recruiting-api.nextcapital.com/users/sign_out'
    url = HTTParty.delete(call, options)
    notice_text = "Logged out"
    if !url.nil?
      response = JSON.parse(url.body)

      if response.has_key?("error")
        notice_text = response["error"]
      end

    end
    reset_session
    redirect_to root_url , notice: notice_text
  end
end