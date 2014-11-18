class StaticPagesController < ApplicationController
  def home
  	if !session[:id].nil?
  		redirect_to users_path
  	end 
  end
end
