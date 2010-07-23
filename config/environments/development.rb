# Settings specified here will take precedence over those in config/environment.rb
# MUST be on for dev, MUST remove this for staging and production
require 'action_mailer'

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true


# We Do NOT care if the mailer can't send in development
  config.action_mailer.raise_delivery_errors = false

