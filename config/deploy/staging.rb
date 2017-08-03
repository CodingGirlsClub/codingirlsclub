server '172.104.78.40', user: 'deploy', roles: %w{web app db}

set :cgc_root_domain, 'codingirls.net'
# If use ssl, set second params as true
set :cgc_sub_domains, [['test.zhubaijia.net', false]]

set :branch, 'develop'
set :puma_workers, 2

set :deploy_to, -> { "/var/www/#{fetch(:application)}_#{fetch(:stage)}" }

# Disable when auto update_crontab
Rake::Task['whenever:update_crontab'].clear
