class User < ActiveRecord::Base
  has_secure_password

  #register with service
  before_create :register_with_service

  private
  	def register_with_service
  		#make registration api call
  		puts "Registering with API" 

  		call = "http://recruiting-api.nextcapital.com/users?email=#{self.email}&passord=#{self.password}"
  		url = HTTParty.post(call)
  		response = JSON.parse(url.body)
  		#save remote userID
		self.remote_id = response["id"]
		#store api_token for current session
		self.api_token = response["api_token"]
	

  	end
end
