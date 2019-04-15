Ofx::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Set up action mailer
  config.action_mailer.raise_delivery_errors = true
  mailconf = Rails.configuration.ofx[:mailer][:development]
  config.action_mailer.delivery_method = mailconf[:delivery_method]
  config.action_mailer.smtp_settings = mailconf[:settings]
  config.action_mailer.default_url_options = { :protocol => 'http://', :host => mailconf[:settings][:domain], :port => ':3000' }
  
  config.action_mailer.default_options = {from: 'no-reply@openeffects.org'}
  
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.serve_static_files = true
   
end
