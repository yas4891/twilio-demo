require 'twilio-ruby'

account_sid = 'INSERT_ACCOUNT_ID'
auth_token = 'INSERT_AUTH_TOKEN'

Twilio::Application.config.twilio_client = Twilio::REST::Client.new account_sid, auth_token
Twilio::Application.config.twilio_app_id = 'INSERT_APP_ID'
