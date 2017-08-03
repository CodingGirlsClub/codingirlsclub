# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "codingirlsclub"
set :scm, :git
set :repo_url, "git@github.com:CodingGirlsClub/codingirlsclub.git"
set :branch, 'master'
set :deploy_to, "/var/www/codingirlsclub/"
set :format, :airbrussh
set :log_level, :debug
set :keep_releases, 5
append :linked_files, "application.yml", "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"
set :bundle_binstubs, nil
set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto
set :pty, true
set :stage, :production
set :rails_env, "production"
set :passenger_restart_with_touch, true

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 4
set :puma_init_active_record, false
set :puma_preload_app, false
namespace :deploy do
  desc 'Assets compile'
  task :compile_assets do
    on roles(:app), wait: 5 do
      execute :sudo, " chmod -R 777 #{release_path}/tmp/cache"
    end
  end
end
