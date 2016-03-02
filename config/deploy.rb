require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/puma'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, '120.24.180.221'
set :repository, 'git@github.com:wjp2013/fandore.git'
case ENV['to']
when 'demo'
  set :branch, 'redesign'
  set :deploy_to, '/home/deployer/www/demo.fandore.com'
else
  set :branch, 'redesign'
  set :deploy_to, '/home/deployer/www/fandore.com'
end
set :keep_releases, 20

# For system-wide RVM install.
# set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, [
  'config/initializers/alipay.rb',
  'config/initializers/wx_pay.rb',
  'config/database.yml',
  'config/oneapm.yml',
  'config/secrets.yml',
  'config/application.yml',
  'public/uploads',
  'tmp',
  'log'
]

# Optional settings:
set :user, 'deployer'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

set :app_path, lambda { "#{deploy_to}/#{current_path}" }

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use[2.3.0@rails4]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/pids"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/sockets"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/secrets.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/secrets.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/oneapm.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/oneapm.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/application.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/application.yml'."]

  queue! %[mkdir -p "#{deploy_to}/shared/config/initializers"]
  queue! %[touch "#{deploy_to}/shared/config/initializers/alipay.rb"]
  queue  %[echo "-----> Be sure to edit 'shared/initializers/alipay.rb'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    # queue! %[npm install bower -g]
    queue! %[bower install]
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      # invoke :'puma:start'
      invoke :'puma:phased_restart'
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

# Commands
# mina puma:phased_restart  # Restart puma (with zero-downtime)
# mina puma:restart         # Restart puma
# mina puma:start           # Start puma
# mina puma:stop            # Stop puma
