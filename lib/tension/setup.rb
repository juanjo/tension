require 'highline/import' 
require 'tension/custom_fixtures'
require 'find'

module Tension
  class Setup
  
    class << self
      def create_admin_user
        raise "Cannot create a second admin user using the rake task." unless User.count == 0
        new.create_admin_user
      end
      def sample_data
        new.load_sample_data
      end
    end
    
    def create_admin_user(password=nil, email=nil, name=nil)
      unless email and password and login and name
        announce "Create the admin user (press enter for defaults)."
        login = prompt_for_admin_login unless login
        email = prompt_for_admin_email unless email
        name = prompt_for_admin_name unless name
        password = prompt_for_admin_password unless password
      end
      attributes = {
        :name => name,
        :password => password,
        :password_confirmation => password,
        :email => email,
        :login => login
      }
      admin = User.create(attributes)
      
      # create an admin role and and assign the admin user to that role
      site_admin = Role.create(:name => 'site_admin', :description => "Site Administrator")
      admin.roles << site_admin
      admin.save
      admin.register!
      admin.activate!      
      admin      
    end
    
    # Uses a special set of fixtures to load sample data
    def load_sample_data
      # load initial database fixtures (in db/sample/*.yml) into the current environment's database
      ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
      Dir.glob(File.join(RAILS_ROOT, "db", 'sample', '*.{yml,csv}')).each do |fixture_file|
        Fixtures.create_fixtures("#{RAILS_ROOT}/db/sample", File.basename(fixture_file, '.*'))
      end

      # make product images available to the app
      #target = "#{RAILS_ROOT}/public/assets/products/"
      #source = "#{RAILS_ROOT}/lib/tasks/sample/products/"
=begin
      Find.find(source) do |f|
        # omit hidden directories (SVN, etc.)
        if File.basename(f) =~ /^[.]/
          Find.prune 
          next
        end

        src_path = source + f.sub(source, '')
        target_path = target + f.sub(source, '')

        if File.directory?(f)
          FileUtils.mkdir_p target_path
        else
          FileUtils.cp src_path, target_path
        end
      end
=end
      announce "Sample extensions have been loaded"
    end
         
    private
      
      def prompt_for_admin_password
        password = ask('Password [tension]: ', String) do |q|
          q.echo = false
          q.validate = /^(|.{5,40})$/
          q.responses[:not_valid] = "Invalid password. Must be at least 5 characters long."
          q.whitespace = :strip
        end
        password = "tension" if password.blank?
        password
      end
      
      def prompt_for_admin_email
        email = ask('Email [tension@example.com]: ', String) do |q|
          q.echo = false
          q.whitespace = :strip
        end
        email = "tension@example.com" if email.blank?
        email
      end  

      def prompt_for_admin_login
        login = ask('Login [admin]: ', String) do |q|
          q.echo = false
          q.validate = /^(|.{5,40})$/
          q.responses[:not_valid] = "Invalid login. Must be at least 5 characters long."
          q.whitespace = :strip
        end
        login = "admin" if login.blank?
        login
      end
            
      def prompt_for_admin_name
       name = ask('Name [Administrator]: ', String) do |q|
         q.echo = false
         q.validate = /^(|.{5,40})$/
         q.responses[:not_valid] = "Invalid name. Must be at least 5 characters long."
         q.whitespace = :strip
       end
       name = "Administrator" if name.blank?
       name
     end

      # ask user if we should generate some sample data
      def sample_data?
        return true if ENV['AUTO_ACCEPT']
        sample = ask('Load Sample Data? [y]: ', String) do |q|
          q.echo = false
          q.whitespace = :strip
        end
        sample == "" or sample == "y" or sample == "yes" or sample == "true"
      end          

      def announce(string)
        puts "\n#{string}"
      end
  end
end