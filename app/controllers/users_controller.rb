class UsersController < ApplicationController
  
  before_action :authorize, except: [:new, :create]

  # GET /users
  def index
    redirect_to @user
  end

  # GET /users/1
  # GET /users/1.json
  def show
    call = "http://recruiting-api.nextcapital.com/users/#{@user.remote_id}/todos.json?api_token=#{@user.api_token}"
    url = HTTParty.get(call)
    @todos = JSON.parse(url.body)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
