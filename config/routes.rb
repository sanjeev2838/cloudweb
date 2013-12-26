Cloudweb::Application.routes.draw do


  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'admin/dashboard#index'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new'
    end
  end

  namespace :admin do
    resources :dashboard
  end


  namespace :api do
    namespace :v1 do
    # for registering new machine
      match  '/hosts' => "machines#create" , :via => :post
      match  '/hosts/:serial_id' => 'machines#destroy', :via => :delete
    # for adding log entry
      match  '/logs' => 'machine_logs#create', :via => :post
    # for adding parent profile
      match  '/profiles' => 'parent_profiles#create', :via => :post
      match  '/profiles/:id' => 'parent_profiles#update', :via => :put
      match  '/profiles/:id' => 'parent_profiles#destroy', :via => :delete
    #for adding childs to parent_profile
      match  '/profiles/:profile_id/childrens' => 'child_profiles#index', :via => :get
      match  '/profiles/:profile_id/childrens' => 'child_profiles#create', :via => :post
      match  '/profiles/:id/childrens/:id' => 'child_profiles#show', :via => :get
      match  '/profiles/:id/childrens/:id' => 'child_profiles#destroy', :via => :delete
      match  '/profiles/:id/childrens/:id' => 'child_profiles#update', :via => :update
    end
  end


  resources :parent_profiles do
    resources :child_profiles
  end

  devise_for :users

  resources :logbooks
  resources :vaccines
  resources :child_brewing_preferences
  resources :child_stats
  resources :machine_logs
  resources :pictures
  resources :machines

end
