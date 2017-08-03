# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "codingirlsclub"
set :repo_url, "git@github.com:CodingGirlsClub/codingirlsclub.git"

set :deploy_to, "/var/www/codingirlsclub/"
set :scm, :git
set :branch, 'master'
set :format, :pretty
set :log_level, :debug
set :keep_releases, 5
set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto
set :pty, true
append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"
set :stage, :production
set :rails_env, "production"
set :passenger_restart_with_touch, true

namespace :deploy do
  desc 'Assets compile'
  task :compile_assets do
    on roles(:app), wait: 5 do
      execute :sudo, " chmod -R 777 #{release_path}/tmp/cache"
    end
  end
end
