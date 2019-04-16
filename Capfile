# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Includes gem bundling tasks
require 'capistrano/bundler'

# Includes tasks from other gems included in your Gemfile
require 'capistrano/rails'
require 'capistrano/rbenv'
require 'capistrano/puma'
install_plugin Capistrano::Puma  # Default puma tasks

require 'capistrano/yarn'
require 'capistrano-db-tasks'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }

