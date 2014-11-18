class TasksController < ApplicationController
	before_action :find_user

	def add
		task_text = params['task']

		 options = { query: {user_id: session[:id], api_token: session[:api_token], todo: {description: task_text}}}     
  		call = "http://recruiting-api.nextcapital.com/users/#{session[:id]}/todos"
  		url = HTTParty.post(call, options)
  		response = JSON.parse(url.body)
		redirect_to users_path
	end

	def update

		options = { query: {api_token: session[:api_token], todo: {description: params['description'], is_complete: params['is_complete']}}}   
  		call = "http://recruiting-api.nextcapital.com/users/#{session[:id]}/todos/#{params['todo_id']}"
  		url = HTTParty.put(call, options)
  		response = JSON.parse(url.body)
  		redirect_to '/users'
	end

	def edit
		options = { query: {api_token: session[:api_token]}}     
  		call = "http://recruiting-api.nextcapital.com/users/#{session[:id]}/todos/#{params['task_id']}"
  		url = HTTParty.get(call, options)
  		response = JSON.parse(url.body)

  		@description = response["description"] 
  		@is_complete = response["is_complete"]
  		@task_id = response["id"]
	end


end