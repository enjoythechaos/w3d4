# Add the Uber Ruby gem:
# Add this line to your application's Gemfile:
# gem 'uber-ruby', require: 'uber'
# And then execute:
# $ bundle
# Or install it yourself as:
# $ gem install uber-ruby

require 'uber'

# These are going to be fixed values. Currently based on Andrews credentials so lets change them before finishing up
SERVER_TOKEN  = "5EqpeWmeYoc8YmzmRZxmkyprXUyBxjMqBCpyj-n3"
CLIENT_ID     = "B4K8XNeyIq4qsI0QqCN8INGv7Ztn1XIL"
CLIENT_SECRET = "iq6ILvHYlZA6I8RrufNB_fVXN5FZixkP99Tkbhv-"

# This one we need from the team in the middle - basically like the session token, we should get it after login success
BEARER_TOKEN = nil

client = Uber::Client.new do |config|
  config.server_token  = SERVER_TOKEN
  config.client_id     = CLIENT_ID
  config.client_secret = CLIENT_SECRET
  config.bearer_token  = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZXMiOlsiaGlzdG9yeV9saXRlIiwicHJvZmlsZSIsImhpc3RvcnkiXSwic3ViIjoiYmQ2NjExZGItYzUwZC00ZDJiLTg0M2EtYTE1Y2I5Njg2MjY3IiwiaXNzIjoidWJlci11czEiLCJqdGkiOiI0ZmJlMTljNS1kNDMwLTQ3NDItYTRjYy02M2ZmZDVlYjk2MTMiLCJleHAiOjE0NDk1NDY2ODksImlhdCI6MTQ0Njk1NDY4OCwidWFjdCI6IkhWZElZdUJ3dmR4T0ZnbFlVcm1tN1JLdmRNOFRndSIsIm5iZiI6MTQ0Njk1NDU5OCwiYXVkIjoiQjRLOFhOZXlJcTRxc0kwUXFDTjhJTkd2N1p0bjFYSUwifQ.agomLxgVHTbm7w9y9tBmwNFd2YsoE2ar2SQepJ8lMu4-mFNUR0U5XofoLXw2KjdQibkmJuJoT-FeGcS1u5UVfFoBr0CvFcshusuM-AVukwOfNaoMpBLELSUhOJq9WVge3wdCxBmlpEPVOvMb_F78OCQgNllOGDifrDX0lSV1tHn8Z_KvTweVDmuwY9O7LjU9b7R_cbIJy5cR97Oy0mEWSEXjaDGIaeu60zNotlA3pK3m2rSKBLuYb9C1kaNgo73Vl4KzXCLxbZdXJeigDSUYmNwIXZpxtwoM8uNDJMhKfigUJlwud5wxV6JXxk024y6bdYfpmnjPzCr2XowvJ_Cn8w"
end


# client.products(latitude: 37.7759792, longitude: -122.41823)
