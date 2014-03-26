# config valid only for Capistrano 3.1
lock '3.1.0'

require 'bundler/capistrano'

set :rvm_ruby_string, :local
set :rvm_autolibs_flag, 'read-only'

set :application, 'ofx'
set :repo_url, 'file://home/ec2-user/git-repos/ofx-staging.git'
set :local_repository,  "ofx-amazon:/home/ec2-user/git-repos/ofx-staging.git"
set :deploy_to, '/var/www/ofx'

set :user, 'ec2-user'

role :web, 'ofx-amazon'
role :app, 'ofx-amazon'
role :db,  'ofx-amazon'

set :ssh_options, { keys: '~/.ssh/ofx-amazon.pem', forward_agent: true}

# Avoid the use of sudo
set :use_sudo, false

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/documentation}


# Precompile assets
load 'deploy/assets'

### TASK LIST
namespace :deploy do

  after :update_code, :link_to_shared_assets
  after :publishing, :restart
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

# If you are using Passenger mod_rails uncomment this:
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end


# Link to share folder assets (documentation and paperclip images
  desc 'Link to share folder assets'
  task 'link_to_shared_assets' do
    run "rm -f #{release_path}/public/system && ln -s /var/www/ofx/shared/system #{release_path}/public/system"
    run "rm -f #{release_path}/public/documentation && ln -s /var/www/ofx/shared/system #{release_path}/public/documentation"
  end

# Copy the share folder assets to the correct place
  desc 'Copy public assets'
  task 'copy_public_assets' do
    run "rsync -r public/system ofx-amazon:/home/ec2-user/shared_assets/ofx/"
    run "rsync -r public/documentaion ofx-amazon:/home/ec2-user/shared_assets/ofx/"
    run "rm #{release_path}/public/system"
    run "cp -r ~/shared_assets/ofx/public/system #{release_path}/public/"
    run "rm #{release_path}/public/documentation"
    run "cp -r ~/shared_assets/public/documentation #{release_path}/public/"
  end

  task :show_tasks do
    exec("cd #{deploy_to}/current; /usr/bin/rake -T")
  end

  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
end
