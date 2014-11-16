# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
secret = Rails.env.production? ? ENV['SECRET_TOKEN'] : "df41cd01eea405dcb51bf35d6ccfbd5c763b9d66d5834c7daf73b10e50b5f490e7f789d61fbb76c4d0061f1cf3406e0925282a7e239fc74981093871b4f18c02
"
YourApp::Application.config.secret_key_base = secret
