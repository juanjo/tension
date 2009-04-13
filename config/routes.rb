ActionController::Routing::Routes.draw do |map|
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil  
  map.resources :users, :as => 'authors'

  map.resource :session


  map.resources :extensions, :collection => {:my_extensions => :get}
  map.resources :versions, :only => [:show]
  map.resources :tags, :only => [:show]  
  
  map.namespace(:admin) do |admin|
    admin.root :controller => 'dashboard', :action => 'index'
    admin.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete, :activate  => :put, :reset_password => :put }
    admin.resources :versions    
    admin.root :controller => 'versions', :action => 'index'
    
  end
  
  
  
  map.root :controller => 'extensions'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
