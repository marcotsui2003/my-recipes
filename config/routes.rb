Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
  controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"}
  devise_scope :user do
    get '/users/twitter_first_signup', to:"registrations#twitter_new", as: 'new_twitter_registration'
    post '/users/twitter_first_signup', to:"registrations#twitter_create"
  end
  resources :authorizations
  resources :users  do
    #resources :posts, only: [:index], as: 'root'
    resources :posts, only: [:create, :new, :update, :edit, :destroy]
  end
  get '/users/:user_id/posts' => 'posts#index', as: 'user_root'

  resources :posts do
    resources :comments, only: [:new, :create, :update, :edit, :destroy]
    resources :replies, only: [:new, :create, :update, :edit, :destroy]
  end

  root 'welcome#home'

  resources :posts, only: [:index, :show]
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
