# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'deploy_capistrano'
set :repo_url, 'git@github.com:lcsbaroni/capistrano_codeship.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/luis/deploy_capistrano'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{public/upload}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Build'
  task :build do
    on roles(:app) do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      within release_path do
        execute :composer, "update" # install dependencies
        execute :chmod, "u+x artisan" # make artisan executable
      end
    end
  end

  desc 'Restart application'
  task :restart do
    # on roles(:app), in: :sequence, wait: 5 do
    on roles(:app) do
      within release_path  do
        execute :chmod, "-R 777 app/storage/"
      end
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

end
