class TasksController < ApplicationController
	before_action :authorize
	
	def add
		task_text = params['task']

		 options = { query: {user_id: @user.remote_id, api_token: @user.api_token, todo: {description: task_text}}}     
  		call = "http://recruiting-api.nextcapital.com/users/#{@user.remote_id}/todos"
  		url = HTTParty.post(call, options)
  		response = JSON.parse(url.body)
		redirect_to @user
	end

	def update

		options = { query: {api_token: @user.api_token, todo: {description: params['description'], is_complete: params['is_complete']}}}   
  		call = "http://recruiting-api.nextcapital.com/users/#{@user.remote_id}/todos/#{params['todo_id']}"
  		url = HTTParty.put(call, options)
  		response = JSON.parse(url.body)
  		redirect_to @user
	end

	def edit
		options = { query: {api_token: @user.api_token}}     
  		call = "http://recruiting-api.nextcapital.com/users/#{@user.remote_id}/todos/#{params['task_id']}"
  		url = HTTParty.get(call, options)
  		response = JSON.parse(url.body)

  		@description = response["description"] 
  		@is_complete = response["is_complete"]
  		@task_id = response["id"]
	end


end