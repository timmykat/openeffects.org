Rails.configuration.ofx = YAML::load(File.open("#{Rails.root}/config/ofx_config.yml")).symbolize_keys
Recaptcha.configure do |config|
  config.public_key = Rails.configuration.ofx[:recaptcha][:public_key]
  config.private_key = Rails.configuration.ofx[:recaptcha][:private_key]
end
