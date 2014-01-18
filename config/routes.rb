LspAlpha::Application.routes.draw do

  # Root application page
  root :to => 'home#root'

  # Resources
  resources :user_sessions
  resources :invites
  resources :user_details
  resources :users do
    resources :bus_vendors
    resources :bus_buyers
    resources :search_logs
  end
  resources :locations, :except => ['show'] do
    get :autocomplete_products_commonName, :on => :collection
  end
  resources :products, :except => ['show'] do
    get :autocomplete_users_login, :on => :collection
    
  end
  resources :product_images
  resources :featured_items

  match "404" => 'static#404'

  # Routes for Cover Photo Things
  match "coverphoto/request" => 'home#coverphoto_submit_request'
  
  # Routes for Guest Link
  match "supplier/guest/login" => 'user_sessions#supplier_guest_login'
  match "supplier/guest/error" => 'user_sessions#supplier_guest_error'
  match "login/guest/supplier" => 'user_sessions#login_guest_supplier'

  # Routes for More Info
  match "supplier/whatsnew" => 'home#supplier_more_info'

  # Routes for Inventory
  match "location/inventory/view" => "locations#inventory_view"

  # Routes for News Feed
  match "main" => "news_feed#main"

  # Routes for Following
  match "follower/create" => 'followers#create'
  match "follower/delete" => 'followers#delete'

  # Routes for Help pages
  match "help" => "users#help"

  # Routes for Search
  get "search/product"
  get "search/supplier"
  post "search/product"
  post "search/supplier"

  # Routes for User Details
  get "user_detail/new"
  get "user_detail/edit"
  match "user/details/new" => "user_details#new"
  match "user/details/edit" => "user_details#edit"
  match "user/validationrequest" => "users#validation_request"
  match "user/email/verify" => "users#verify_email"
  match "user/create/validate" => "users#validation_sent"
  match "user/email/sendverification" => "users#send_validation_request"
  match "user/email/verify/error" => "users#validation_error"
  
  # Routes for Invites and Claiming accounts
  match "invite/create" => 'users#create_invite'
  match "invite/success" => 'users#invite_confirm'
  match "invite/register" => "users#new"
  match "account/claim" => "users#temp_claim_account"
  match "profile/claim" => "users#claim_profile"
  match "profile/claim/create" => "users#create_claimed_profile"
  match "profile/claim/success" => "users#claim_profile_success"
  match "profile/buyer/claim" => "users#claim_buyer_profile"
  match "profile/buyer/claim/create" => "users#create_claimed_buyer_profile"
  match "profile/buyer/claim/success" => "users#claim_buyer_profile_success"
  
  # Routes for Password Reset, Forgot, and Feedback
  match "feedback/success" => 'home#feedback_success'
  match 'password/reset' => 'users#password_reset_form'
  match 'password/forgot' => 'users#password_forgot_form'
  match 'password/reset/update' => 'users#password_reset_update'
  match 'password/forgot/update' => 'users#password_forgot_update'
  match "forgot" => 'user_sessions#forgot'
  match "forgot/success" => 'user_sessions#forgot_submitted'
  post "/submit_forgot" => 'user_sessions#submit_forgot'

  # Routes for products
  match 'products/show' => 'products#show'
  match 'products/favorite/set' => 'products#set_as_favorite'
  match 'products/view' => 'products#view'
  match 'products/edit' => 'products#edit'

  # Routes for Public Profiles
  match "locations/edit/profile/url" => "locations#set_public_url"
  match "locations/edit/profile/update" => "locations#update_public_settings"
  match "location/public/url/deactivate" => "locations#public_url_deactivate"
  match "location/public/url/activate" => "locations#public_url_activate"
  
  # Routes for locations
  post "inventory/upload" => 'locations#inventory_upload'
  post 'locations/:id/edit' => 'products#create'
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

  match "locations/:id" => 'locations#manage'

  # For home controller
  match "home" => 'home#index'
  match 'index' => 'home#index'
  match "about" => 'home#about'
  match "contact" => 'home#contact'
  match "contact/submit" => 'home#contact_submit'
  match "feedback/submit" => 'application#submit_feedback'

  # Routes for Admin stuff
  match 'admin' => 'admin#main'
  match 'admin/weekly' => 'admin#dashboard_weekly'
  match 'admin/users' => 'admin#dashboard_users'
  match 'admin/email' => 'admin#dashboard_email'
  match 'admin/user/view' => 'admin#user_view'
  match 'admin/user/verify' => 'admin#user_verify'
  match 'admin/user/activate' => 'admin#user_activate'
  match 'admin/user/deactivate' => 'admin#user_deactivate'
  match 'admin/location/activate' => 'admin#location_activate'
  match 'admin/location/deactivate' => 'admin#location_deactivate'
  match "admin/dashboard_main" => 'admin#main'
  match "admin/signinas" => 'admin#sign_in_as_user'
  get "admin/dashboard_weekly"
  get "admin/dashboard_email"
  get "admin/user_view"

  # For account register, login, logout, etc.
  match "register" => 'users#new'
  match "login" => 'user_sessions#new'
  match "logout" => 'user_sessions#destroy'
  match "dashboard" => 'users#dashboard'
  match "account" => 'users#account'
  match "back" => "application#back"
  match "terms" => "home#terms"
  match "oops" => 'home#oops'
  match "products/browse/all" => 'products#browseall'
  match ":public_url" => "locations#view_public"
  match "profiles/:public_url" => "locations#view_public"

  # TODO: DELETE THESE
  match "supplier/new" => 'bus_vendors#new'
  match "buyer/new" => 'bus_buyers#new'

  

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
