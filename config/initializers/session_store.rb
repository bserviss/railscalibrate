# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_calibration_session',
  :secret      => '7b14de68c2abceabcf41260d7de4eeb8b4d91f45e12e39647b5336a30ac0ea5c55fd3e9cd28e177390457dcec1c284a3aef87eee4665e70b8fbbb92983cfd894'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
