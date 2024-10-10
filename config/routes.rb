Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'welcome#index'

  resources :users, only: %i[new create]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy', as: 'logout'
end
