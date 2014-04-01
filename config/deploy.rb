# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'openeffects.org'
#set :repo_url, 'file://ofx-amazon:/home/ec2-user/git-repos/openeffects.org.git'
set :repo_url, 'ssh://ec2-user@ec2-54-186-175-209.us-west-2.compute.amazonaws.com/home/ec2-user/git-repos/openeffects.org.git'

## default is /var/www/#{:application}
set :deploy_to, '/var/www/openeffects.org'

# We're deploying the production environment
set :rails_env, 'production'

set :ssh_options, {
  forward_agent: true
}

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/ofx_config.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle vendor/assets}
set :linked_dirs, fetch(:linked_dirs) << 'public/assets' << 'public/system' << 'public/documentation' << 'public/unprepped'

## 'capistrano-db-tasks' settings
# Clean up database dump file
set :db_local_clean, true
set :assets_dir, %w(public/assets public/system public/documentation)

namespace :deploy do
  desc 'Copy ofx config file (kluge!)'
  task :copy_correct_config
    on roles(:app), in: :sequence, wait: 5 do
      execute :cp, '~/ofx_config.yml', shared_path.join('config')
    end
  end
  
  before :restart, :copy_correct_config
  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      system "curl -I --silent #{fetch(:ping_url)}"
    end
  end

end
