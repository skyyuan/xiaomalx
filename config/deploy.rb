# encoding: utf-8
set :stages, %w(production xiaomalxtest)
set :default_stage, "production"
set :application, 'xiaomalx'

set :use_sudo, false
set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true
set :deploy_env, 'production'
set :deploy_via, :remote_cache
set :keep_releases, 5
set :rvm_type, :user

set :rvm_ruby_version, 'ruby-1.9.3-p547'
set :default_env, { rvm_bin_path: '~/.rvm/bin' }
SSHKit.config.command_map[:rake] = "#{fetch(:default_env)[:rvm_bin_path]}/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec rake"

desc 'make production database.yml link'
task :symlink_db_yml do
  on roles(:all) do
    execute "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end


desc "Compile assets"
task :assets do
  run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile"
end
