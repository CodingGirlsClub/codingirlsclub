# config valid only for current version of Capistrano
lock '3.8.1'

set :application,     'codingirlsclub'
set :scm,             :git
set :repo_url,        'git@github.com:CodingGirlsClub/codingirlsclub.git'
set :branch,          :master
set :deploy_to,       -> { "/var/www/#{fetch(:application)}_#{fetch(:stage)}" }
set :format,          :airbrussh
set :log_level,       :debug
set :pty,             false
set :keep_releases,   1000
set :linked_files,    ['config/application.yml', 'config/database.yml', 'config/secrets.yml']
set :linked_dirs,     ['log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads']
set :bundle_binstubs, nil

# Rails
set :rails_env,                   'production'
set :assets_roles,                [:web]
set :assets_prefix,               'assets'
set :migration_role,              'db'
set :conditionally_migrate,        true
set :passenger_restart_with_touch, true

set :nginx_config_name,          -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :nginx_sites_available_path, '/etc/nginx/sites-available'
set :nginx_sites_enabled_path,   '/etc/nginx/sites-enabled'

set :puma_user,       -> { fetch(:user) }
set :puma_rackup,     -> { File.join(current_path, 'config.ru') }
set :puma_state,      -> { "#{shared_path}/tmp/pids/puma.state" }
set :puma_pid,        -> { "#{shared_path}/tmp/pids/puma.pid" }
set :puma_bind,       -> { "unix://#{shared_path}/tmp/sockets/puma.sock" }
set :puma_conf,       -> { "#{shared_path}/puma.rb" }
set :puma_access_log, -> { "#{shared_path}/log/puma_access.log" }
set :puma_error_log,  -> { "#{shared_path}/log/puma_error.log" }
set :puma_role,       :app
set :puma_env,        fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads,    [0, 16]
set :puma_workers,    4
set :puma_worker_timeout, 300
set :puma_init_active_record, false
set :puma_preload_app,        false
set :puma_prune_bundler,      true
set :puma_default_hooks,      false  # Do not auto check puma config and restart app
set :puma_control_app,        false

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end


namespace :cgc do
  task :test do
  end

  # Turn on maintenance mode
  task :m_enable do
    on roles(:web) do
      require 'erb'

      template = File.join(File.expand_path('../deploy/templates', __FILE__), 'maintenance.html.erb')
      result = ERB.new(File.read(template)).result(binding)

      rendered_path = "#{shared_path}/public/system/"
      rendered_name = "maintenance.html"

      if test "[ ! -d #{rendered_path} ]"
        info 'Creating missing directories.'
        execute :mkdir, '-pv', rendered_path
      end

      upload!(StringIO.new(result), rendered_path + rendered_name)
      execute "chmod 644 #{rendered_path + rendered_name}"
    end
  end

  # Turn off maintenance mode
  task :m_disable do
    on roles(:web) do
      execute "rm -f #{shared_path}/public/system/maintenance.html"
    end
  end

  namespace :nginx do
    %w[start stop status restart reload force-reload upgrade configtest].each do |command|
      task command do
        on roles(:web) do
          sudo :service, 'nginx', command
        end
      end
    end
  end

  namespace :puma do
    %w[start stop restart status].each do |command|
      task command do
        on roles(:app) do
          sudo :service, 'puma-manager', command
        end
      end
    end
  end

  task :setup do
    puts "Run as root on #{fetch(:stage)} =>"
    puts <<-EOB
      deploy_to=#{fetch(:deploy_to)}
      mkdir -p ${deploy_to}
      chown deploy:deploy ${deploy_to}
      umask 0002
      chmod g+s ${deploy_to}
      mkdir ${deploy_to}/{releases,shared}
      chown deploy ${deploy_to}/{releases,shared}
    EOB

    puts 'Prepare linked files'
    fetch(:linked_files).each do |f|
      puts "\t#{f}"
    end

    # http://capistranorb.com/documentation/getting-started/authentication-and-authorisation
    puts 'Prepare nginx and puma'
    puts "\tinvoke:puma:nginx_config"
    puts "\tinvoke:puma:config"
  end

  task :copy_assets_manifest do
    assets_path = release_path.join('public', fetch(:assets_prefix))
    manifest_name, manifest_contents = nil, nil

    on primary(fetch(:assets_roles)) do
      candidate = assets_path.join('.sprockets-manifest*')
      if test(:ls, candidate)
        manifest_name = capture(:ls, candidate).strip.gsub(/(\r|\n)/, ' ')
        manifest_contents = download!(assets_path.join(manifest_name))
      else
        msg = 'Rails assets manifest file not found.'
        warn msg
        fail msg
      end
    end

    on roles(:app) do
      upload! StringIO.new(manifest_contents), assets_path.join(manifest_name)
    end
  end
end

namespace :git do
  task :update_repo_url do
    on roles(:all) do
      within repo_path do
        execute :git, 'remote', 'set-url', 'origin', fetch(:repo_url)
      end
    end
  end
end
