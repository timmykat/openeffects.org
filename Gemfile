source 'https://rubygems.org'

# As per http://stackoverflow.com/questions/18627075/nokogiri-1-6-0-still-pulls-in-wrong-version-of-libxml-on-os-x
gem 'nokogiri'

# User rails 4
gem 'rails', '4.0.1'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use haml for templates
gem 'haml-rails'

# Javascript environment
gem 'therubyracer'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

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

# Truncate html properly
gem 'truncate_html'

# FriendlyId for nice looking urls
gem 'friendly_id'

# Need to hand assets without digests for the API docs
gem 'non-stupid-digest-assets', :git => "https://github.com/timmykat/non-stupid-digest-assets"
 
# Development tools
group :development do
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'puma'

  # Use capistrano for deployment (not needed in production)
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'capistrano-db-tasks', require: false
end


# For testing
group :development, :test do
  gem 'factory_girl_rails', "4.4.0"  
end

group :test do
  gem 'pry'
  gem 'shoulda'
  gem 'shoulda-callback-matchers'
#  gem 'database_cleaner'
end


# Use this ruby version  
ruby '2.1.5'

