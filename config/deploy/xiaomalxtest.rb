
set :rvm_ruby_string, '1.9.3-p547'
set :rvm_type, :user

server '192.168.1.158', roles: %w{web app db}, user: "xiaomaxl", password: "admins"

set :repo_url, "git@github.com:skyyuan/xiaomalx.git"
set :branch, "master"
set :deploy_to, "/home/xiaomaxl/xiaomalx"


namespace :deploy do
  set :unicorn_config, "#{current_path}/config/unicorn.rb"
  set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

  desc 'Restart application'
  task :restart do
    on roles(:all), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute "if [ -f #{fetch(:unicorn_pid)} ]; then kill -USR2 `cat #{fetch(:unicorn_pid)}`; fi"
    end
  end

  desc 'stop application'
  task :stop do
    on roles(:all), in: :sequence, wait: 5 do
    execute "if [ -f #{fetch(:unicorn_pid)} ]; then kill -QUIT `cat #{fetch(:unicorn_pid)}`; fi"
    end
  end

  desc 'start application'
  task :start do
    on roles(:all), in: :sequence, wait: 5 do
    within "#{current_path}" do
        with rails_env: "production", bundle_gemfile: fetch(:bundle_gemfile) do
        execute :bundle, :exec, "unicorn_rails -c #{fetch(:unicorn_config)} -D"
        end
      end
    end
  end

  desc 'init db seed'
  task :seed do
    on roles(:all), in: :sequence, wait: 5 do
    within "#{current_path}" do
        with rails_env: "production" do
        execute :rake, "db:seed"
        end
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  before 'start', 'rvm:hook'
  after :finishing, 'deploy:cleanup'
end