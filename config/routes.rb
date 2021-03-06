Rails.application.routes.draw do
  resources :skills
  #devise_for :users, path: '/users', :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  devise_for :users, module: "users"
  resources :skills
  #resources :user_skills
  resources :users do
    scope module: :users do
      resources :skills
    end
  end

  # Callback finish url
  #match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  # Callback url
  match '/auth/:provider/callback', :to => 'sessions#create', via: [:get, :post]

  # The priority is based upon order of creation: first creased -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index'
  #root 'test#index'

  get '*path' => redirect('/')

  post 'skills/search'
  post 'users/search'
  post 'skills/endorseskill'
  post 'users/endorseuser'
  
	

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
