set :whenever_command, "bundle exec whenever"  # set this first if using bundler
require "whenever/capistrano"
after "deploy:symlink", "deploy:update_crontab"  

namespace :deploy do  
  desc "Update the crontab file"  
  task :update_crontab, :roles => :db do  
     run "cd #{release_path} && whenever --update-crontab #paymeback"  
  end  
end 
