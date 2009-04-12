class CreateExtensionsVersions < ActiveRecord::Migration
  def self.up
    create_table :extensions_versions, :id => false do |t|
      t.references :extension, :null => false
      t.references :version, :null => false
    end
    
  end

  def self.down
    drop_table :extensions_versions
  end
end
