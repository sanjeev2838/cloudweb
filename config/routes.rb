Cloudweb::Application.routes.draw do

  resources :cars


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
    resources :dashboard do
      collection do
        get :staff_users
      end
    end

  end

  namespace :api do
    namespace :v1 do

    # for registering new machine
      match  '/hosts' => "machines#create" , :via => :post
      match  '/hosts/:serialid' => 'machines#destroy', :via => :delete
      match  '/hosts'  => 'machines#show', :via => :get

    # for adding log entry
      match  '/logs' => 'machine_logs#create', :via => :post

    # for adding parent profile
      match  '/profiles' => 'parent_profiles#create', :via => :post
      match  '/profiles/:id' => 'parent_profiles#update', :via => :put
      match  '/profiles/:id' => 'parent_profiles#destroy', :via => :delete

    #for adding childs to parent_profile
      match  '/profiles/:profile_id/children' => 'child_profiles#index', :via => :get
      match  '/profiles/:profile_id/children' => 'child_profiles#create', :via => :post
      match  '/profiles/:profile_id/children/:id' => 'child_profiles#show', :via => :get
      match  '/profiles/:profile_id/children/:id' => 'child_profiles#destroy', :via => :delete
      match  '/profiles/:profile_id/children/:id' => 'child_profiles#update', :via => :put

    # for child brewing preferences
      match '/profiles/:profile_id/children/:child_id/brew' => 'child_brewing_preferences#index', :via => :get
      match '/profiles/:profile_id/children/:child_id/brew' => 'child_brewing_preferences#update', :via => :put

    # for adding child stats
      match '/profiles/:profile_id/children/:child_id/stats' => 'child_stats#create', :via => :post
      match '/profiles/:profile_id/children/:child_id/stats' => 'child_stats#index', :via => :get

    # for getting all vaccines
      match '/vaccines' => 'vaccines#index',  :via => :get

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
