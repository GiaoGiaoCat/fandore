APP_ROOT = '/home/deployer/sites/fandore/current'
bind  "unix:///tmp/fandore.sock"
pidfile "#{APP_ROOT}/tmp/pids/puma.pid"
state_path "#{APP_ROOT}/tmp/pids/puma.state"
daemonize true
workers 4
threads 8,64
preload_app!