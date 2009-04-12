class CreateExtensions < ActiveRecord::Migration
  def self.up
    create_table :extensions do |t|
      t.references :user, :null => false
      t.string :name, :null => false
      t.string :summary, :null => false
      t.text :description
      t.string :website
      t.string :scm_location, :null => false
      t.string :permalink, :null => false
      
      t.boolean :github, :default => false
      t.string :username
      t.string :repository

      t.timestamps
    end
    
    add_index :extensions, :user_id
        
  end

  def self.down
    drop_table :extensions
  end
end
