# config valid only for Capistrano 3.1
lock '3.4.0'

application = 'blyad'
login = 'dload'
$user = 'hosting_' + login
$server = 'hydrogen.locum.ru'
rvm_ruby_string = '2.2.0'
deploy_to = "/home/#{ $user }/projects/#{ application }"
unicorn_conf = "/etc/unicorn/#{ application }.#{ login }.rb"
unicorn_pid = "/var/run/unicorn/#{ $user }/#{ application }.#{ login }.pid"
unicorn_start_cmd = "(cd #{ deploy_to }/current; rvm use #{ rvm_ruby_string } do bundle exec unicorn_rails -Dc #{ unicorn_conf })"

set :application, application
set :repo_url, "ssh://#{ $user }@#{ $server }/home/#{ $user }/git/hi.git"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, deploy_to

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, {
                    # Выполните на удаленном сервере
                    # $ echo $PATH  и результат поместите сюда:
                    path: '/usr/local/rvm/gems/ruby-2.1.5/bin:/usr/local/rvm/gems/ruby-2.1.5@global/bin:/usr/local/rvm/rubies/ruby-2.1.5/bin:/usr/local/rvm/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/X11R6/bin:/home/hosting_kenny/.gem/ruby/1.8/bin:/var/lib/gems/1.8/bin:/home/hosting_kenny/local/lib/python2.7/site-packages:/home/hosting_kenny/local/lib:/home/hosting_kenny/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games'
                }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end