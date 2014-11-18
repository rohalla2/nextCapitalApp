class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  	def find_user
  		if session[:id].nil?
  			redirect_to root_url
  		end
  	end

end
