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

  get "error", to: "pages#error", as: "error"
  
  # post "stripe_webhook", to: "subscribers#stripe_charge"
  
  post 'stripe_webhook' => 'subscribers#stripe_charge'


  %w(404 422 500 503).each do |code|
    get code, to: "pages#error", code: code
  end

  # games
  get "games", to: "games#index"

  namespace :games do
    
    scope "word_search", as: "word_search" do
      get "", to: "word_search#index"
      post "found_word", to: "word_search#found_word"
    end

    scope "flash_cards", as: "flash_cards" do
      get "", to: "flash_cards#index"
      post "attempt", to: "flash_cards#attempt", as: "attempt_flash_card"
      post "toggle_options", to: "flash_cards#toggle_options"
    end
  end

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
  resources :notifications, only: [:index, :show] do
    collection do
      get "check_all"
    end
    member do
      get "toggle"
    end
  end
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
    resources :articles
    resources :article_topics
    namespace :dashboard do
      resources :notifications do
        collection do
          get "check_all"
        end
        member do
          get "toggle"
        end
      end
      resources :comment_notifications do
        collection do
          get "check_all"
        end
        member do
          get "toggle"
        end
      end
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
      member do
        get "/rearrange", to: "courses#rearrange"
        post "/rearrange", to: "courses#post_rearrange"
        post "/import_vocabulary_words", to: "lessons#import_vocabulary_words"
        post "/import_quizzes", to: "courses#import_quizzes"
      end
      resources :lessons do
        resources :vocabulary_words, only: [:update, :destroy]
        member do
          post "/import_quiz", to: "lessons#import_quiz"
        end
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
  end
  
  resources :subscribers


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
