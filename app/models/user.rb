class User < ActiveRecord::Base
  
  before_validation :downcase_username
  before_create :downcase_username
  before_save :downcase_username

  validates :email, presence: true, uniqueness: true

  #register with service
  #after_validation :register_with_service
  has_secure_password
  
  private
  	def downcase_username
		self.email.downcase!
	end
  	
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
