LspAlpha::Application.routes.draw do

  get "location/edit"

  get "locations/show"

  get "location/search"

  get "location/browse"

  get "location/favorite"

  get "product/new"

  get "product/edit"

  get "product/show"

  get "product/search"

  get "product/browse"

  get "product/favorite"

  get "profile/edit"

  get "profile/view"

  # Root application page
  root :to => 'home#index'

  # Resource routes for models
  resources :user_sessions
  resources :users do
    resources :bus_vendors
    resources :bus_buyers
    resources :search_logs
    resources :fav_locations
    resources :fav_products
  end
  resources :products do
    resources :product_images
  end
  resources :locations

#  resources :locations do
#    resources :featured_items
#    resources :contacts
#  end

  resources :product_categories

  # For home controller
  match "home" => 'home#index'
  match "about" => 'home#about'
  match "contact" => 'home#contact'

  # For account register, login, logout, etc.
  match "register" => 'users#new'
  match "login" => 'user_sessions#new'
  match "logout" => 'user_sessions#destroy'

  # For dealing with account once registered and logged in
  match "account" => 'account#view'
  match "account/view" => 'account#view'
  match "account/edit" => 'account#edit'

  match "account/search" => 'account#search'
  match "account/location/new" => 'account#newloc'

  # Routes for vendor's businesses
  match "business/vendor/show" => 'bus_vendors#show'
  match "business/vendor/new" => 'bus_vendors#new'

  match "business/vendor/dashboard" => 'bus_vendors#manage'
  match "business/vendor/locations/view" => 'bus_vendors#manage', :view => 'view_locations'
  match "business/vendor/locations/manage" => 'bus_vendors#manage', :view => 'manage_locations'
  match "business/vendor/account/manage" => 'bus_vendors#manage', :view => 'manage_account'

  # Routes for buyer's businesses
  match "business/buyer/show" => 'bus_buyers#show'
  match "business/buyer/new" => 'bus_buyers#new'
  match "business/buyer/manage" => 'bus_buyers#manage'

  match "business/buyer/dashboard" => 'bus_buyers#manage'
  match "business/buyer/account/manage" => 'bus_buyers#manage', :view => 'manage_account'

  # Routes for locations
  match "business/vendor/locations/new" => 'locations#new'

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
