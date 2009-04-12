# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_extspree_session',
  :secret      => '6dc93d6ef64135941f859bd2a8105f1996497d73f4d4349afe4d29554c2f15d0df01beff98460364e317cdaa70c755c81269cf0a94dad55e10224d8d7e231f77'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
