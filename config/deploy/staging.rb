server '172.104.78.40', user: 'deploy', roles: %w{web app db}
set :branch, 'develop'
set :stage, 'production'
