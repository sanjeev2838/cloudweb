Cloudweb::Application.routes.draw do

  get "password_resets/new"

  resources :vendors do
    resources :products do
      resources :child_brewing_preferences
    end
  end

  resources :products do
    resources :child_brewing_preferences
  end

  resources :milestones


  resources :vaccine_languages


  resources :vaccine_ages


  resources :diaries


  #get "users/new"
  resources :users

  resources :languages


  resources :firmwares


  root :to => 'sessions#new'

  namespace :admin do
    resources :dashboard do
      collection do
        get :staff_users
      end
    end
  end

  #for admin users
  resources :sessions, only: [:new, :create, :destroy]
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/firmware/:id/download', to: 'firmwares#download_firmware_file', via: 'get' , as: :download_firmware


  namespace :api do
    namespace :v1 do
      resources :child_stats  do
        collection do
           get :child_vaccines,:child_meals ,:child_diapers,:child_full_bottles,:child_half_bottles
        end
        end

# for registering new machine

      match  '/hosts' => 'machines#create' , :via => :post
      match  '/hosts/:serialid' => 'machines#destroy', :via => :delete
      match  '/hosts/:serialid'  => 'machines#show', :via => :get

      match '/verify'  => 'machines#update', :via => :put
# for adding log entry

      match  '/logs' => 'machine_logs#create', :via => :post

# for login and logout for user
      match  '/login'  => 'sessions#create', :via => :post
      match  '/logout' => 'sessions#destroy', :via => :delete
      match '/forgot'  => 'sessions#update', :via=>:put

# for adding parent profile

      match  '/profiles' => 'parent_profiles#create', :via => :post
      match  '/profiles/:id' => 'parent_profiles#update', :via => :put
      match  '/profiles/:id' => 'parent_profiles#destroy', :via => :delete
      match  '/profiles/:id' => 'parent_profiles#show', :via => :get
#for adding children to parent_profile

      match  '/profiles/:profile_id/children' => 'child_profiles#index', :via => :get
      match  '/profiles/:profile_id/children' => 'child_profiles#create', :via => :post
      match  '/profiles/:profile_id/children/:id' => 'child_profiles#show', :via => :get
      match  '/profiles/:profile_id/children/:id' => 'child_profiles#destroy', :via => :delete
      match  '/profiles/:profile_id/children/:id' => 'child_profiles#update', :via => :put

#for adding logs for children activities

      match  '/profiles/:profile_id/children/:children_id/logbook' => 'logbooks#index', :via => :get
      match  '/profiles/:profile_id/children/:children_id/logbook' => 'logbooks#create', :via => :post
      match  '/profiles/:profile_id/children/:children_id/logbook/:id' => 'logbooks#show', :via => :get
      match  '/profiles/:profile_id/children/:children_id/logbook/:id' => 'logbooks#destroy', :via => :delete
      match  '/profiles/:profile_id/children/:children_id/logbook/:id' => 'logbooks#update', :via => :put

      match  '/profiles/:profile_id/children/:id/get_pdf' => 'child_profiles#get_pdf', :via => :get
      match  '/profiles/:profile_id/children/:id/email_dairy_pdf' => 'child_profiles#email_diary_records', :via => :get
    # for child brewing preferences

      match '/profiles/:profile_id/children/:child_id/brew' => 'child_brewing_preferences#index', :via => :get
      match '/profiles/:profile_id/children/:child_id/brew' => 'child_brewing_preferences#update', :via => :put

    # for adding child stats

      match '/profiles/:profile_id/children/:child_id/stats' => 'child_stats#create', :via => :post
      match '/profiles/:profile_id/children/:child_id/stats' => 'child_stats#index', :via => :get
      match '/profiles/:profile_id/children/:child_id/vaccines'=> 'child_stats#child_vaccines', :via => :get
      match '/profiles/:profile_id/children/:child_id/meals'=> 'child_stats#child_meals', :via => :get
      match '/profiles/:profile_id/children/:child_id/diapers'=> 'child_stats#child_diapers', :via => :get
      match '/profiles/:profile_id/children/:child_id/fullbottles'=> 'child_stats#child_full_bottles', :via => :get
      match '/profiles/:profile_id/children/:child_id/halfbottles'=> 'child_stats#child_half_bottles', :via => :get


    # for getting all vaccines

      match '/vaccines' => 'vaccines#index',  :via => :get

   # Api for child pictures

      match  '/profiles/:profile_id/children/:children_id/pictures' => 'pictures#create', :via => :post
      match  '/profiles/:profile_id/children/:children_id/pictures/:id' => 'pictures#show', :via => :get
      match  '/profiles/:profile_id/children/:children_id/pictures/:id' => 'pictures#destroy', :via => :delete
      match  '/profiles/:profile_id/children/:children_id/pictures' => 'pictures#index', :via => :get

   # Api for diary
       match  '/profiles/:profile_id/children/:children_id/diaries' => 'diaries#index', :via => :get
       match  '/profiles/:profile_id/children/:children_id/diary' => 'diaries#create', :via => :post
      #match  '/profiles/:profile_id/children/:children_id/logbook/:id' => 'logbooks#show', :via => :get
      #match  '/profiles/:profile_id/children/:children_id/logbook/:id' => 'logbooks#destroy', :via => :delete
      #match  '/profiles/:profile_id/children/:children_id/logbook/:id' => 'logbooks#update', :via => :put

   # Api for milestones
      match '/milestones' => 'milestones#index',  :via => :get

  # Api for firmware
      match '/firmware/:machine_id' => 'firmwares#show' ,:via => :get

   # Api for languages
   #   match '/languages' => 'langages#index',  :via => :get
    end

    namespace :v2 do
      match '/suppliers' => 'vendors#vendors_as_brew_type', :via => :get
      match '/suppliers/:supplierid/products' => 'vendors#products_of_vendor_as_brew_type',:via => :get
      match '/suppliers/:supplierid/products/:productid/preferences' => 'products#product_preferences', :via => :get
    end

  end




  resources :parent_profiles do
    collection do
      get :make_machine_owner
    end
    resources :child_profiles
  end



  resources :logbooks
  resources :vaccines
  resources :child_brewing_preferences
  resources :child_stats
  resources :machine_logs
  resources :pictures

  resources :machines  do
    collection do
      get :machines_import,:machine_csv_download
      post :import_machine_csv
    end
  end

  resources :password_resets

  match "*path", :to => "application#routing_error"


end
