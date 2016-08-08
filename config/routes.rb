Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  root 'pages#index'

  get "signin", to: "sessions#new", as: "sign_in"
  post "signin", to: "sessions#create"
  get "signout", to: "sessions#destroy", as: "sign_out"

  get "signup", to: "users#new", as: "sign_up"

  get "blog", to: "articles#index"

  get "email_confirm", to: "email_signups#confirm"

  resources :users, only: [:create]
  resources :articles, only: [:show] do
    resources :comments, only: [:create]
  end

  resources :categories, only: [:show]
  
  resources :email_signups, only: [:create]

  resources :courses, only: [:index, :show] do
    resources :lessons, only: [:show] do
      post "complete", as: "complete_lesson"
      resources :quizzes do
        post "attempt", as: "attempt_quiz"
      end
    end
    member do 
      post "enroll"
    end
  end


  namespace :admin do
    resources :courses do
      resources :lessons do
        resources :quizzes do
          resources :questions do
            resources :choices
          end
        end
      end
    end
    resources :email_signups, only: [:index]
    resources :users
    resources :categories
    resources :articles, only: [:new, :create, :edit, :destroy]
  end


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
