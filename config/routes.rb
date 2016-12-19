Rails.application.routes.draw do
  # Zones
  get 'zones/add_zone' => 'zones#add_zone'
  resources :zones
  # Basins
  get '/basins/add_basin' => 'basins#add_basin'
  get 'basins/:id/edit_form' => 'basins#edit_form'
  resources :basins
  # Companys
  resources :companies
  # Dashboard
  root to: 'dashboard#index'
  # Comments
  resources :comments
  # Properties
  get 'properties/add_new_property' => 'properties#add_new_property'
  post 'properties/create_new_properties' => 'properties#create_new_properties'
  resources :properties
  # Sites
  get 'sites/:id/site_data' => 'sites#site_data'
  post 'sites/:id/upload' => 'sites#upload'
  resources :sites
  # Users and Devise
  devise_scope :user do
    get '/sign-in' => "devise/sessions#new", :as => :login
  end
  devise_for :users, :path => 'auth', controllers: {confirmations: 'confirmations'} do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  post '/users/:id/impersonate' => 'users#impersonate'
  resources :users
  # Reports
  resources :reports
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
