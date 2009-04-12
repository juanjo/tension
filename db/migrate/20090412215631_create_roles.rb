class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table "roles" do |t|
      t.string :name, :null => false
      t.string :description, :null => false
    end

    Role.create(:name => 'site_admin', :description => 'Site Administrator')
    
    # generate the join table
    create_table "roles_users", :id => false do |t|
      t.references :role, :null => false
      t.references :user, :null => false
    end
    add_index "roles_users", "role_id"
    add_index "roles_users", "user_id"
  end

  def self.down
    drop_table :roles
    drop_table :roles_users
  end
end