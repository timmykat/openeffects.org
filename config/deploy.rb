# config valid only for Capistrano 3.1
lock "~> 3.11.0"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :application, 'openeffects.org'

set :ssh_options, {
  forward_agent: true
}

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.6.2'

set :rbenv_prefix, "env RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake erb gem bundle rails pry ruby}
set :rbenv_roles, :all # default value


# Default value for :linked_files is []
set :linked_files, %w{ puma.rb config/database.yml config/ofx_config.yml public/.htaccess }

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log node_modules tmp/pids tmp/cache tmp/sockets }
set :linked_dirs, fetch(:linked_dirs) << 'public/assets' << 'public/system' << 'public/documentation' << 'public/unprepped'

## 'capistrano-db-tasks' settings
# Clean up database dump file
set :db_local_clean, true
set :assets_dir, %w(public/assets public/system public/documentation)


set :puma_init_active_record, true

# namespace :deploy do  
#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end
# 
#   after :publishing, :restart
# 
#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       system "curl -I --silent #{fetch(:ping_url)}"
#     end
#   end
# 
# end
