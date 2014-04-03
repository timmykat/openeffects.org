# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :web, %w{ec2-user@ec2-54-186-175-209.us-west-2.compute.amazonaws.com}
role :app, %w{ec2-user@ec2-54-186-175-209.us-west-2.compute.amazonaws.com}
role :db, %w{ec2-user@ec2-54-186-175-209.us-west-2.compute.amazonaws.com}

# We're deploying the production environment
set :rails_env, 'staging'                     # Mostly mirrors production

# On Amazon EC2
set :ping_url, 'http://ofx.wordsareimages.com'
set :repo_url, 'ssh://ec2-user@ec2-54-186-175-209.us-west-2.compute.amazonaws.com/home/ec2-user/git-repos/openeffects.org.git'
set :deploy_to, '/var/www/openeffects.org'

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
# server 'ec2-54-186-175-209.us-west-2.compute.amazonaws.com', user: 'deploy', roles: %w{web}, primary: true

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
