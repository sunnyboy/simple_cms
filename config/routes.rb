SimpleCms::Application.routes.draw do
  resources :partners
  resources :documents do
    member do
      post "update"
    end
  end
  resources :stories do
    member do
      post "update"
    end
  end
  resources :pages do
    member do
      post "update"
    end
  end
  resources :sections do
    member do
      post "update"
    end
  end


  get "dropbox/authorize"
  get "dropbox/import"

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
