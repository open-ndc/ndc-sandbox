require 'mina/bundler'
require 'mina/git'
require 'mina/rvm'    # for rvm support. (http://rvm.io)

set :application, 'FIXME: app name goes here'
set :domain, 'FIXME: ip goes here'
set :deploy_to, "/home/apps/#{application}"
set :repository, 'FIXME: github url goes here'
set :branch, 'master'
set :env, ENV['ENV'] || :production

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['log']

set :user, 'apps'         # Username in the server to SSH to.
set :forward_agent, true  # Use my deploying user's identity to clone from github

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # For those using RVM, use this to load an RVM version@gemset.
  # FIXME: change your_app_name to the gemset you want to use
  invoke :'rvm:use[ruby-2.0.0@your_app_name]'

  # Prevent RVM from complaining when we use rvmsudo
  queue! "export rvmsudo_secure_path=1"
end

# Put any custom mkdir's in here for when `mina setup` is ran.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]
end

task 'db:migrate' do
  queue! %[ bin/rake db:migrate DATABASE_ENV=#{env} ]
end

# Mina has its own version of this in mina/foreman but it does not
# play nice with rvm and sudo.
task 'foreman:export' do
  queue "rvmsudo bin/foreman export upstart /etc/init -a #{application} -u #{user} -d #{deploy_to}/$release_path -l #{shared_path}/log -p 8000"
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke 'git:clone'
    invoke 'deploy:link_shared_paths'
    invoke 'bundle:install'

    to :launch do
      invoke 'db:migrate'
      invoke 'foreman:export'
      queue "sudo start #{application} || sudo restart #{application}"
    end
  end
end
