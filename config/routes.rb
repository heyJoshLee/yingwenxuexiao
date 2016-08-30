Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  root 'pages#index'

  # sessions
  get "signin", to: "sessions#new", as: "sign_in"
  post "signin", to: "sessions#create"
  get "signout", to: "sessions#destroy", as: "sign_out"

  get "signup/", to: "users#new", as: "sign_up"

  get "blog", to: "articles#index", as: "blog"
  get "account", to: "users#show", as: "account"
  get "contact", to: "pages#contact", as: "contact"
  get "careers", to: "pages#careers", as: "careers"
  get "upgrade", to: "pages#upgrade", as: "upgrade"
  get "help", to: "pages#help", as: "help"
  get "free", to: "pages#free", as: "free"

  # practice
  get "practice", to: "practices#index"
  get "practice/start", to: "practices#start", as: "start_practice"
  post "practice/change_options", to: "practices#change_options", as: "change_practice_options"
  post "practice/attempt", to: "practices#attempt", as: "attempt_practice"

  get "email_confirm", to: "email_signups#confirm"

  # downloads goes to download links, only the admin access downloads directly
  get "downloads/:id", to: "download_links#show", as: "download"
  post "downloads/:id/start_download", to: "download_links#start_download", as: "start_download"

  resources :password_resets, only: [:new, :create, :show]
  get "expired_password_token", to: "forgot_passwords#expired"

  resources :forgot_passwords, only: [:create, :new]

  get "forgot_password_confirmation", to: "forgot_passwords#confirm"

  get "my_words", to: "user_vocabulary_words#show"

  resources :password_resets, only: [:show, :create]
  
  resources :users, only: [:create, :edit, :update]
  resources :article_topics, only: [:show]
  resources :articles, only: [:show] do
    resources :comments, only: [:create] do
      resources :replies
    end
  end
  
  resources :email_signups, only: [:create]

  # regular user
  namespace :help do
    resources :support_tickets
  end

  resources :user_vocabulary_words, only: [:create]
  
  resources :affiliates, only: [:index, :show]
  resources :course_levels, only: [:show]
  
  resources :courses, only: [:index, :show] do
    resources :lessons, only: [:show] do
      post "complete", as: "complete_lesson"
      resources :comments do
        resources :replies
      end
      resources :quizzes do
        post "attempt", as: "attempt_quiz"
      end
    end
    member do 
      post "enroll"
    end
  end

  # admin
  namespace :admin do
    resources :article_topics
    namespace :dashboard do
      resources :affiliates do
        resources :affiliate_links
      end
      resources :course_levels
      resources :vocabulary_words
      resources :levels
      resources :downloads
      get "/", to: "dashboard#index"
    end
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
    resources :articles, only: [:new, :create, :edit, :destroy, :update]
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
