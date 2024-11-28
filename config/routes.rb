Rails.application.routes.draw do
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" 
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
      
  get "up" => "rails/health#show", as: :rails_health_check

  root 'posts#index'

  resources :users, only: %i[show new create]
  resources :posts do
    resources :post_details, shallow: true do
      collection do
        get 'publish'
      end
    end
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
