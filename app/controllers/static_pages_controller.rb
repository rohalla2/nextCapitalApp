class StaticPagesController < ApplicationController
  def home
  	if @user
  		redirect_to @user
  	end 
  end
end
