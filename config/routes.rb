LspAlpha::Application.routes.draw do


  match "profile/:public_url" => "locations#view_public"
  match "invite/register" => "users#new"
  match "account/claim" => "users#temp_claim_account"
  match "profile/claim" => "users#claim_profile"
  match "profile/claim/create" => "users#create_claimed_profile"
  match "profile/claim/success" => "users#claim_profile_success"
  match "profile/buyer/claim" => "users#claim_buyer_profile"
  match "profile/buyer/claim/create" => "users#create_claimed_buyer_profile"
  match "profile/buyer/claim/success" => "users#claim_buyer_profile_success"

  match "locations/edit/profile/url" => "locations#set_public_url"
  match "locations/edit/profile/update" => "locations#update_public_settings"

  get "favorites/products"

  get "favorites/vendors"

  get "locations/autocomplete_product_commonName"

  match "oops" => 'home#oops'

  match "invite/request" => 'users#request_invite'
  match "invite/create" => 'users#create_invite'
  match "invite/success" => 'users#invite_confirm'
  match "forgot" => 'user_sessions#forgot'
  match "forgot/success" => 'user_sessions#forgot_submitted'
  match "feedback/success" => 'home#feedback_success'
  match "back" => "application#back"
  match "terms" => "home#terms"
  match "help" => "application#help"

  post "/submit_forgot" => 'user_sessions#submit_forgot'

  # Root application page
  root :to => 'home#root'

  # Resource routes for models

  match "supplier/update" => 'bus_vendors#update'
  match "buyer/update" => "bus_buyers#update"
  resources :user_sessions
  resources :invites
  resources :users do
    resources :bus_vendors
    resources :bus_buyers
    resources :search_logs
    resources :fav_locations
    resources :fav_products
  end
  resources :locations, :except => ['show'] do
    get :autocomplete_products_commonName, :on => :collection
  end
  resources :products, :except => ['show'] do
    get :autocomplete_users_login, :on => :collection
    
  end
  resources :product_images
  resources :featured_items

  # Routes for favorites
  match 'favorites/products' => 'favorites#products'
  match 'favorites/vendors' => 'favorites#vendors'

  match 'password/reset' => 'users#password_reset_form'
  match 'password/forgot' => 'users#password_forgot_form'
  match 'password/reset/update' => 'users#password_reset_update'
  match 'password/forgot/update' => 'users#password_forgot_update'

  # Routes for products
  match 'products/search' => 'products#search'
  match 'products/show' => 'products#show'
  match 'products/favorite/set' => 'products#set_as_favorite'
  match 'products/view' => 'products#view'
  match 'products/edit' => 'products#edit'
  
  # Routes for locations
  post 'locations/:id/edit' => 'products#create'
  post 'users/:id/bus_vendors' => 'bus_vendors#create'

  match "locations" => 'locations#manage'
  
  match "locations/new" => 'locations#new'
  match "locations/manage" => 'locations#manage'
  match "locations/view" => 'locations#view'
  match "locations/edit/:id" => 'locations#edit'
  match "locations/edit" => 'locations#edit'
  match "locations/delete" => 'locations#destroy'
  match "locations/delete/confirm" => 'locations#confirm_destroy'
  match "locations/favorite/set" => 'locations#set_as_favorite'
  match "locations/status/update" => 'locations#update_status'
  match "locations/bio/update" => 'locations#update_bio'
  match "locations/featureditem/update" => 'locations#update_featured_item'
  match "locations/update_categories" => 'locations#update_categories'

  match "locations/edit/featureditem/add/:id" => 'locations#add_item'
  match "locations/featureditem/delete" => 'locations#delete_featureditem'
  match "locations/featureditem/delete/confirm" => 'locations#confirm_delete_featureditem'

  match "locations/deactivate" => 'locations#deactivate_location'
  match "locations/activate" => 'locations#activate_location'
  
  match "locations/search" => 'locations#search'
  match "locations/:id" => 'locations#manage'

  # For home controller
  match "home" => 'home#index'
  match 'index' => 'home#index'
  match "about" => 'home#about'
  match "contact" => 'home#contact'
  match "contact/submit" => 'home#contact_submit'
  match "feedback/submit" => 'application#submit_feedback'
  match "subscribe" => 'home#subscribe'

  # For account register, login, logout, etc.
  match "register" => 'users#new'
  match "login" => 'user_sessions#new'
  match "logout" => 'user_sessions#destroy'
  match "dashboard" => 'users#dashboard'
  match "account" => 'account#manage'
  match "account/company" => 'account#manage_company'
  match "products/browse/all" => 'products#browseall'

  # Routes for vendor's businesses
  match "supplier/new" => 'bus_vendors#new'
  match "supplier/dashboard" => 'users#dashboard'
  match "supplier/account" => 'bus_vendors#manage'
  match "supplier/company" => 'bus_vendors#manage_company'
  #match "supplier/welcome" => 'bus_vendors#welcome_help'
  match "supplier/help" => 'bus_vendors#help'

  # Routes for buyer's businesses
  match "buyer/new" => 'bus_buyers#new'
  match "buyer/dashboard" => 'users#dashboard'
  match "buyer/account" => 'bus_buyers#manage'
  match "buyer/company" => 'bus_buyers#manage_company'
  #match "buyer/welcome" => 'bus_buyers#welcome_help'
  match "buyer/help" => 'bus_buyers#help'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
