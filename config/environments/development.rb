Calibration::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  #config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  # Raise exception on mass assignment protection for Active Record models
  # prep for 3.2 upgrade
  #config.active_record.mass_assignment_sanitizer = :strict
 
  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  #prep for 3.2 upgrade
  #config.active_record.auto_explain_threshold_in_seconds = 0.5
  
  Paperclip.options[:command_path] = "C://bin//ImageMagick-6.6.3-Q16/"
end

