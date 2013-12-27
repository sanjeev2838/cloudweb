Cloudweb::Application.routes.draw do

  root :to => "admin/dashboard#index"

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
      match  '/profiles/:id/childrens' => 'child_profiles#index', :via => :get
      match  '/profiles/:id/childrens' => 'child_profiles#create', :via => :post
      match  '/profiles/:id/childrens/:id' => 'child_profiles#show', :via => :get
      match  '/profiles/:id/childrens/:id' => 'child_profiles#destroy', :via => :delete
      match  '/profiles/:id/childrens/:id' => 'child_profiles#update', :via => :update
    end
  end

  devise_for :users

  resources :logbooks
  resources :vaccines
  resources :child_brewing_preferences
  resources :child_stats
  resources :machine_logs
  resources :pictures
  resources :child_profiles
  resources :parent_profiles
  resources :machines

end
