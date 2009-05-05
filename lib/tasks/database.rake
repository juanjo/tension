require 'activerecord'              

namespace :db do
  desc "Migrate schema to version 0 and back up again. WARNING: Destroys all data in tables!!"
  task :remigrate => :environment do
    require 'highline/import'       
    
    if ENV['SKIP_NAG'] or ENV['OVERWRITE'].to_s.downcase == 'true' or agree("This task will destroy any data in the database. Are you sure you want to \ncontinue? [yn] ")

      # Drop all tables
      ActiveRecord::Base.connection.tables.each { |t| ActiveRecord::Base.connection.drop_table t }

      # Migrate upward 
      Rake::Task["db:migrate"].invoke
      
      # Dump the schema
      Rake::Task["db:schema:dump"].invoke
    else
      say "Task cancelled."
      exit
    end
  end
        
  namespace :admin do                       
    desc "Create admin username and password"
    task :create => :environment do
      require 'authlogic'     
      Tension::Setup.create_admin_user      
    end
  end     
  
  desc "Bootstrap your database for Spree."
  task :sample  => :environment do
    require 'highline/import'       
    require 'authlogic'     
    require 'tension/setup'

    # prompt user for admin account details if the admin user does not exist yet
    Rake::Task["db:admin:create"].invoke unless User.count > 0      
    Tension::Setup.sample_data
  end
end
