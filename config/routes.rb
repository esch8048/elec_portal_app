ElecPortalApp::Application.routes.draw do
  resources :rss_items
  resources :rss_feeds
  resources :posts
  resources :topics
  resources :forums
  resources :microposts, only: [:create, :destroy]
  resources :users
  resources :sessions

  get "users/new"
  get "portal_home" => "portal_home#index", :as => "portal_home"
  
  controller :portal_home do
	post 'redeempoints' => :redeem_points
	get 'change_settings' => :change_settings
  end
  root to: 'static_pages#home'

  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match '/points_whats_this', to: 'portal_home#points_whats_this'
  match '/customise_feed', to: 'portal_home#customise'
  match '/signup',  to: 'users#new'
  match '/home', 	to: 'static_pages#home'
  match '/signin',	to: 'sessions#new'
  match '/signout',	to: 'sessions#destroy'
  match '/logged_in', to: 'sessions#logged_in'
  match '/settings', to: 'portal_home#settings'
  match '/redeempoints', to: 'portal_home#redeempoints'
  match '/portal_home_redeem', to: 'portal_home#redeem_points'
  match '/edit_settings', to: 'portal_home#edit_settings'
  match '/forum', to: 'forums#index'
  match '/blog', to: 'static_pages#blogs_home'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  
  
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
