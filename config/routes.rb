SimpleCms::Application.routes.draw do
  # get "public/index"
  # 
  # get "public/show"
  # 
  # get "admin_users/list"
  # get "admin_users/new"
  # get "admin_users/edit"
  # get "admin_users/delete"

  root              :to => "public#index"
  match "admin",    :to => "access#menu"
  match "login",    :to => "access#login"
  match "logout",   :to => "access#logout"
  match "show/:id", :to => "public#show"  
  
  match ':controller(/:action(/:id(.:format)))'
end
