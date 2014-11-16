class User < ActiveRecord::Base
  
  before_validation :downcase_username
  before_create :downcase_username
  before_save :downcase_username

  validates :email, presence: true, uniqueness: true

  #register with service
  before_create :register_with_service
  has_secure_password
  
  private
  	def downcase_username
		self.email.downcase!
	end
  	
  	def register_with_service
  		#make registration api call
  		puts "Registering with API" 

      options = { query: {email: self.email, password: self.password}}     
  		call = "http://recruiting-api.nextcapital.com/users"
  		url = HTTParty.post(call, options)
  		response = JSON.parse(url.body)
  		#save remote userID
  		puts "XXXXRESPONSEXXXX"
  		puts response
		self.remote_id = response["id"]
		#store api_token for current session
		self.api_token = response["api_token"]
		#session['api_token'] = response["api_token"]

  	end
end
