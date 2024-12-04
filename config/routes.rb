Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'posts#index'

  resources :users, only: %i[show new create]
  resources :posts do
    collection do
      get 'search', to: 'posts#search', as: :search
    end
    resources :post_details, shallow: true do
      collection do
        get 'publish'
      end
    end
    resources :comments, only: %i[create destroy]
    resource :likes, only: %i[create destroy]
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'terms_of_service', to: 'pages#terms_of_service'
end
