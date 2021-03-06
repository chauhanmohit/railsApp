Rails.application.routes.draw do
  #get 'map_page/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
    # You can have the root of your site routed with "root"
  root 'map_page#index'
  get '/' => 'map_page#index'
  get 'map/listView' => 'map_page#listView'
  get 'map/trendView' => 'map_page#trendsView'
  ## for desktop or web user to hit the api for get request
  get 'api/web/data' => 'api_handeler#data'
  
  ### for desktop or web user to hit the api for post request
  get 'api/web/getlistViewContent' => 'api_handeler#getlistViewContent'
  
  ## for mobile user to hit the api
  get 'api/mobile/data' => 'api_handeler#mobileData'
  
  #users routes path
  
  #resource
  resources :user
  #routes
  get    'register'  => 'users#register'
  post   'register'  => 'users#register'
  get    'login'   => 'users#new'
  post   'login'   => 'users#new'
  get    'logout'  => 'users#destroy'
  get    'dashboard'    => 'users#dashboard'
  
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
