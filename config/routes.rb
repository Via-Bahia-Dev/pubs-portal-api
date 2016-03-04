Rails.application.routes.draw do

  post 'sign_in' => 'sessions#create'
  delete 'sign_out' => 'sessions#destroy'
  resources :users, only: [:index, :create, :update, :destroy] do
    collection do
      get 'admins'
      get 'designers'
      get 'reviewers'
    end
    member do
      put 'update_password'
    end
  end
  get 'users/show/(:id)' => "users#show"
  resources :password_resets, only: [:create, :edit, :update]

  resources :publication_requests, only: [:index, :show, :create, :update, :destroy] do
    resources :request_attachments, only: [:index, :create]
    resources :comments, only: [:index, :create]
  end
  resources :request_attachments, only: [:show, :update, :destroy]
  resources :comments, only: [:show, :update, :destroy]

  resources :statuses, only: [:index, :show, :create, :update, :destroy]
  resources :templates, only: [:index, :show, :create, :update, :destroy]
  resources :tags, only: [:index]

  # This needs to be last!
  match "/*path",
    to: proc {
      [
        204,
        {
          "Content-Type"                 => "text/plain",
          "Access-Control-Allow-Origin"  => CORS_ALLOW_ORIGIN,
          "Access-Control-Allow-Methods" => CORS_ALLOW_METHODS,
          "Access-Control-Allow-Headers" => CORS_ALLOW_HEADERS
        },
        []
      ]
    }, via: [:options, :head]
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
