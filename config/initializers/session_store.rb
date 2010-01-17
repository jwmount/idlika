# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_idlika_session',
  :secret      => '7a70d9751a81377f18809cd8bcdee594e216ec0793ae12a5f9d7b9c22ab9ca957a7387cd476acd0fe1fac59fe30759d1668630141066b09bc435071d686ca995'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
