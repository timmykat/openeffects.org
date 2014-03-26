# config valid only for Capistrano 3.1
lock '3.1.0'

set :rvm_ruby_string, :local
set :rvm_autolibs_flag, 'read-only'

set :application, 'openeffects.org'
set :repo_url, 'file://home/ec2-user/git-repos/ofx-staging.git'

## default is /var/www/#{:application}
set :deploy_to, '/var/www/openeffects.org'

set :user, 'ec2-user'

role :web, 'ofx-amazon'
role :app, 'ofx-amazon'
role :db,  'ofx-amazon'

set :ssh_options, { keys: '~/.ssh/ofx-amazon.pem', forward_agent: true}

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/ofx_config.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/documentation}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
