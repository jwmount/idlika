# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_idlika_session',
  :secret      => '8d6996e448fe4ed6faf88cd626decf779f3c98152a58427cc8511f23afefb02d08ba8540419816525070473ed917840033b4c7f13ce5e7b583933a6c90bff65e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
