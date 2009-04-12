class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :activation_code,           :string, :limit => 40
      t.column :activated_at,              :datetime
      t.column :state,                     :string, :null => :no, :default => 'passive'
      t.column :deleted_at,                :datetime
      t.column :extensions_count,          :integer, :default => 0
    end
    add_index :users, :login, :unique => true
    
    user = User.create do |u|
      u.login = 'admin'
      u.name = 'Steve Jobs'
      u.password = u.password_confirmation = 'tension'
      u.email = 'example@example.org'
    end

    user.register!
    user.activate!
    
    
    Extension.create(:author => user, :name => 'Sermepa pago', :summary => 'AskSaurabh lets you post and find jobs for IT professionals in India affected by the economic downturn.', :scm_location => 'git://github.com/radiant/radiant-aggregation-extension.git', :description => 'Un formulario web puede tener variadas formas y objetivos (un formulario de contacto, una registración, una encuesta) pero muchas veces el hecho de que éste tenga o no éxito va a depender de como haya sido conformado y diseñado. 

    Best Practices for Web Form Design es un completo documento, realizado por Luke Wroblewski, en donde se detallan todos los aspectos a tener en cuenta al diseñar y crear un formulario: Usabilidad, organización de los elementos, flexibilidady por supuesto, tips y buenas prácticas con cantidad de ejemplos.

    El documento es muy recomendable y puede descargarse en PDF (133 páginas, 4 MB) o verlo online como presentación:')
    Extension.create(:author => user, :name => 'page_attachments', :summary => 'AskSaurabh lets you post and find jobs for IT professionals in India affected by the economic downturn.', :scm_location => 'git://github.com/radiants/radiant-aggregation-extension.git')
    Extension.create(:author => user, :name => 'aggregation', :summary => 'AskSaurabh lets you post and find jobs for IT professionals in India affected by the economic downturn.', :scm_location => 'git://github.com/radiant/rdadiant-aggregation-extension.git')
    Extension.create(:author => user, :name => 'Cucumber', :summary => 'AskSaurabh lets you post and find jobs for IT professionals in India affected by the economic downturn.', :scm_location => 'git://github.com/radiant/radiant-abggregation-extension.git')
    Extension.create(:author => user, :name => 'Colorful Spree', :summary => 'AskSaurabh lets you post and find jobs for IT professionals in India affected by the economic downturn.', :scm_location => 'git://github.com/radiant/radciant-aggregation-extension.git')
    Extension.create(:author => user, :name => 'Liquid Templates', :summary => 'AskSaurabh lets you post and find jobs for IT professionals in India affected by the economic downturn.', :scm_location => 'git://github.com/radiant/radiaent-aggregation-extension.git')
    Extension.create(:author => user, :name => 'Ruport Reports', :summary => 'AskSaurabh lets you post and find jobs for IT professionals in India affected by the economic downturn.', :scm_location => 'git://github.com/radiant/radiant-aggregation-extension.git')
    Extension.create(:author => user, :name => 'ProductRSS', :summary => 'AskSaurabh lets you post and find jobs for IT professionals in India affected by the economic downturn.', :scm_location => 'git://github.com/radiant/radi2ant-aggregation-extension.git')
    Extension.create(:author => user, :name => 'Kaneida Spree Machine', :summary => 'AskSaurabh lets you post and find jobs for IT professionals in India affected by the economic downturn.', :scm_location => 'git://github.com/radiant/radivant-aggregation-extension.git')    
    
    
    
  end

  def self.down
    drop_table "users"
  end
end
