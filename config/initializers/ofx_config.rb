Rails.configuration.ofx = YAML::load(File.open("#{Rails.root}/config/ofx_config.yml"))
Recaptcha.configure do |config|
  config.public_key = Rails.configuration.ofx['recaptcha']['public_key']
  config.private_key = Rails.configuration.ofx['recaptcha']['private_key']
end
