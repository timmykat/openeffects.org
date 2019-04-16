# Change to match your CPU core count
workers 1 # ENV['CPU_CORES']

# Min and Max threads per worker
threads 1, 6

app_dir = '/var/www/openeffects.org/current'
tmp_dir = "#{app_dir}/tmp"

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

# Set up port
port 3000

# Logging - let docker handle the logging
# stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{tmp_dir}/pids/puma.pid"
state_path "#{tmp_dir}/pids/puma.state"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end