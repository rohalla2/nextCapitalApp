class TasksController < ApplicationController

	def add
		task_text = params['task']

		 options = { query: {user_id: @user.remote_id, api_token: @user.api_token, todo: {description: task_text}}}     
  		call = "http://recruiting-api.nextcapital.com/users/#{@user.remote_id}/todos"
  		url = HTTParty.post(call, options)
  		response = JSON.parse(url.body)
		redirect_to @user
	end

end