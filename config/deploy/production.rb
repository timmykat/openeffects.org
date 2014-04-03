# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :app, %w{openeffe@74.220.215.119}
role :web, %w{openeffe@74.220.215.119}
role :db,  %w{openeffe@74.220.215.119}

# We're deploying the production environment
set :rails_env, 'production'

#set :repo_url, 'file://ofx-amazon:/home/ec2-user/git-repos/openeffects.org.git'
set :repo_url, 'ssh://openeffe@74.220.215.119/home4/openeffe/git-repos/ofx-website.git'

## default is /var/www/#{:application}
set :deploy_to, '/home4/openeffe/web_apps/ofx-website'

set :tmp_dir, "/home4/openeffe/tmp"
set :ssh_options, {
  keys: [File.join(ENV["HOME"], ".ssh", "ofx-hostmonster")]
}

set :linked_dirs, fetch(:linked_dirs) << '.bundle' # Need a version of Nokogiri compiled on HostMonster


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options
