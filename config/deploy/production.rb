server '172.104.78.40', user: 'deploy', roles: %w{app db web}
set :cgc_root_domain, 'zhubaijia.com'
# If use ssl, set second params as true
set :cgc_sub_domains, [['www.codingirls.com', false]]

set :branch, 'master'
set :puma_workers, 4

set :deploy_to, -> { "/var/www/#{fetch(:application)}_#{fetch(:stage)}" }
