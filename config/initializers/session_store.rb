# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_copyblog_session',
  :secret      => '489ec5aa0089c6701c0ac6c0f9c12f5f2f5faa6c800f8647b557c51010b70a5df89ff84815192809e1fa4557cf1d1dca148debe0ab759a911bbe9d963bd462f5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
