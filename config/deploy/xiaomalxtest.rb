
set :rvm_ruby_string, '1.9.3-p547'
set :rvm_type, :user

server '192.168.1.158', roles: %w{web app db}, user: "xiaomaxl", password: "admins"

set :repo_url, "git@github.com:skyyuan/xiaomalx.git"
set :branch, "master"
set :deploy_to, "/home/xiaomaxl/xiaomalx"


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