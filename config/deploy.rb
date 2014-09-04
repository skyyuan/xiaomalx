# encoding: utf-8
# config valid only for Capistrano 3.1
lock '3.2.1'

set :stages, %w(production xiaomalxtest)
set :default_stage, "production"
set :application, 'xiaomalx'

set :use_sudo, false
set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true
set :deploy_env, 'production'
# set :deploy_via, :remote_cache
set :keep_releases, 5
set :rvm_ruby_version, 'ruby-1.9.3-p547@xiaomalx'
# set :default_env, { rvm_bin_path: '~/.rvm/bin' }
# SSHKit.config.command_map[:rake] = "#{fetch(:default_env)[:rvm_bin_path]}/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec rake"

set :linked_files, %w{config/database.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}