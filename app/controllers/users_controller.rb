class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  # GET /users
  def show
    call = "http://recruiting-api.nextcapital.com/users/#{session[:id]}/todos.json?api_token=#{session[:api_token]}"
    url = HTTParty.get(call)
    @todos = JSON.parse(url.body)
  end

  # POST /users
  def create
    #check that passwords match
    if params['password'] != params['password_confirmation']
      redirect_to '/users/new', notice: "Passwords did not match!" and return
    end

    options = { query: {email: params['email'], password: params['password']}}     
    call = "http://recruiting-api.nextcapital.com/users"
    url = HTTParty.post(call, options)
    response = JSON.parse(url.body)

    if response["email"] == params['email']
      session[:id] = response["id"]
      session[:api_token] = response["api_token"]
      session[:email] = response["email"]
      redirect_to '/users' and return
    else
      redirect_to '/users/new', notice: 'Email has already been registered!' and return

    end

    
  end

end

