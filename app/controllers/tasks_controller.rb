class TasksController < ApplicationController

	def add
		task_text = params['task']
		puts "TASK ADDED"
		puts task_text
		redirect_to @user
	end

end