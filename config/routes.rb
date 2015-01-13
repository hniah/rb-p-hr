Rails.application.routes.draw do
  devise_for :users, skip: [:registration], controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'logged_in#dashboard'
  get :help, to: 'logged_in#help'
  get :pcc, to: 'logged_in#pcc'

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

  namespace :admin do
    resources :lates
    resources :feedbacks, only: [:index]
    resources :leaves do
      member do
        patch 'approve'
        get 'reject'
        patch 'reject_action'
      end
    end
    resources :settings
    resources :staffs do
      resources :leaves, only: [:index], controller: 'staffs/leaves'
      resources :lates, only: [:index], controller: 'staffs/lates'
      resources :versions, only: [:index], controller: 'staffs/versions'
    end
  end

  namespace :staff do
    get 'profile', to: 'staffs#show'
    resources :leaves, only: [:index, :new, :create, :show]
    resources :lates, only: [:index]
  end

  resources :feedbacks, only: [:new, :create]
  resource :annuals do
    collection do
      get 'add_annual_leave_days'
    end
  end

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
