class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.string :name, :null => false

      t.timestamps
    end
    
    # Add Spree Sessions
    Version.create(:name => "0.5.0")
    Version.create(:name => "0.5.1")
    Version.create(:name => "0.6.0")
    Version.create(:name => "0.6.99")
    
    
  end

  def self.down
    drop_table :versions
  end
end
