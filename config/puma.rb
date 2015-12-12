#!/usr/bin/env puma
require 'puma'

# http://demo.gitlab.com/gitlab/gitlabhq/blob/master/config/puma.rb.example
# Start Puma with next command:
# bundle exec puma

# Set the environment in which the rack's app will run.
#
# The default is “development”.
#
environment 'production'

# Daemonize the server into the background. Highly suggest that
# this be combined with “pidfile” and “stdout_redirect”.
#
# The default is “false”.
#
daemonize true

workers 4
threads 16, 40

wd = File.expand_path('../../', __FILE__)
tmp_path = File.join(wd, 'tmp')
log_path = File.join(wd, 'log')
Dir.mkdir(tmp_path) unless File.exist?(tmp_path)

# Store the pid of the server in the file at `path`.
pidfile File.join(tmp_path, 'pids', 'puma.pid')

# Use `path` as the file to store the server info state. This is
# used by `pumactl` to query and control the server.
state_path File.join(tmp_path, 'sockets', 'puma.state')

# Redirect STDOUT and STDERR to files specified.
stdout_redirect File.join(log_path, 'puma.out.log'), File.join(log_path, 'puma.err.log'), true

# Bind the server.
bind "unix:///home/deployer/www/demo.fandore.com/shared/tmp/sockets/puma.sock"

preload_app! #utilizing copy-on-write
activate_control_app 'unix:///home/deployer/www/demo.fandore.com/shared/tmp/sockets/pumactl.sock'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
