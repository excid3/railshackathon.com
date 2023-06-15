require 'sidekiq/web'

Rails.application.routes.draw do

  resources :events do
    resources :teams, module: :events, only: :index
    resources :entries, module: :events, only: :index
  end
  
  
  resources :votes, only: [:index, :create, :destroy] do
    resource :move, only: [], module: :votes do
      collection do
        patch "up"
        patch "down"
      end
    end
  end

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

  resources :entries, except: :index
  resources :invitations
  resources :teams, except: :index do
    resources :users, module: :teams
    resources :invitations, module: :teams
  end

  resource :newsletter

  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  get '/rules', to: 'home#rules'
  get '/resources', to: "home#resources"
  get '/winners', to: "home#winners"
  get '/teams', to: redirect("events/1-hotwire/teams")
  get '/entries', to: redirect("events/1-hotwire/entries")
  
  authenticated :user do
    root to: 'dashboard#show', as: :authenticated_root
  end

  root to: 'home#index'
end
