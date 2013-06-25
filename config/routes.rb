LspAlpha::Application.routes.draw do

  get "favorites/products"

  get "favorites/vendors"

  get "locations/autocomplete_product_commonName"

  # Root application page
  root :to => 'home#root'

  # Resource routes for models

  match "business/vendor/update" => 'bus_vendors#update'
  resources :user_sessions
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

  match 'user/password/reset' => 'users#password_reset'
  match 'user/password/update' => 'users#update_password'
  match 'password/reset' => 'users#password_reset_form'

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
  match "locations/categories/update" => 'locations#update_categories'
  match "locations/featureditem/update" => 'locations#update_featured_item'

  match "locations/edit/featureditem/add/:id" => 'locations#add_item'
  match "locations/featureditem/delete" => 'locations#delete_featureditem'
  match "locations/featureditem/delete/confirm" => 'locations#confirm_delete_featureditem'

  match "locations/search" => 'locations#search'

  # For home controller
  match "home" => 'home#index'
  match 'index' => 'home#index'
  match "about" => 'home#about'
  match "contact" => 'home#contact'
  match "contact/submit" => 'home#contact_submit'
  match "subscribe" => 'home#subscribe'

  # For account register, login, logout, etc.
  match "register" => 'users#new'
  match "login" => 'user_sessions#new'
  match "logout" => 'user_sessions#destroy'
  match "dashboard" => 'users#dashboard'
  match "account" => 'account#manage'
  match "products/browse/all" => 'products#browseall'

  # Routes for vendor's businesses
  match "business/vendor/show" => 'bus_vendors#show'
  match "business/vendor/new" => 'bus_vendors#new'
  match "business/vendor/dashboard" => 'bus_vendors#dashboard'
  match "business/vendor/manage" => 'bus_vendors#manage'

  # Routes for buyer's businesses
  match "business/buyer/show" => 'bus_buyers#show'
  match "business/buyer/new" => 'bus_buyers#new'
  match "business/buyer/dashboard" => 'bus_buyers#dashboard'
  match "business/buyer/manage" => 'bus_buyers#manage'

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
