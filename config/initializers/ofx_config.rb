Recaptcha.configure do |config|
  config.site_key = Rails.configuration.ofx[:recaptcha][:public_key]
  config.secret_key = Rails.configuration.ofx[:recaptcha][:private_key]
end
