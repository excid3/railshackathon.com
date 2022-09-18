require 'sidekiq/web'

Rails.application.routes.draw do
  resources :votes, only: [:index, :create, :destroy] do
    resource :move, only: [], module: :votes do
      collection do
        patch "up"
        patch "down"
      end
    end
  end
 
  resources :entries
  resource :leaderboard, only: [:show]
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'

    namespace :madmin do
      resources :impersonates do
        post :impersonate, on: :member
        post :stop_impersonating, on: :collection
      end
    end
  end

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]

  resources :invitations
  resources :teams do
    resources :users, module: :teams
    resources :invitations, module: :teams
  end

  resource :newsletter

  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  get '/rules', to: 'home#rules'
  get '/resources', to: "home#resources"

  authenticated :user do
    root to: 'dashboard#show', as: :authenticated_root
  end

  root to: 'home#index'
end
