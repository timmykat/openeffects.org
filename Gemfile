source 'https://rubygems.org'

# User rails 4
gem 'rails', '4.0.1'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use haml for templates
gem 'haml-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Design and layout
gem 'bootstrap-sass', '~> 3.1.1'


# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# gem 'jquery-turbolinks'

# User
gem 'devise'      # authentication
gem 'role_model'  # user roles

# WYSWIG editor - ckeditor
# gem 'ckeditor'
gem 'tinymce-rails'

# Sanitize HTML output
gem 'sanitize'

# User forum
# gem 'forem'

# Use paperclip for file uploads
gem 'paperclip'

# Need commenting for draft standard changes
gem 'acts_as_commentable'

# reCaptcha to hold down the spam
gem 'recaptcha', :require => 'recaptcha/rails'

# group :doc do
#   # bundle exec rake doc:rails generates the API under doc/api.
#   gem 'sdoc', require: false
# end
 
# Development tools
group :development do
  gem 'pry-rails'
  gem 'pry-debugger'
  gem 'pry-stack_explorer'
  gem 'better_errors'
end

# Stuff for heroku
group :production do
  gem 'rails_12factor'
  gem 'thin'
end

# For testing
group :development, :test do
#  gem 'rspec-rails', '~> 3.0.0.beta2'
  gem 'factory_girl_rails', "4.4.0"
end

group :test do
  gem 'pry'
  gem 'shoulda'
  gem 'shoulda-callback-matchers'
#  gem 'database_cleaner'
end

# Use this ruby version  
ruby '1.9.3'

