class AddAdminUsers < ActiveRecord::Migration
  def self.up
    
    role_admin = Role.find_by_name('site_admin')
    juanjo = User.find_by_login('admin')
    
    juanjo.roles << role_admin
    
    
  end

  def self.down
  end
end
