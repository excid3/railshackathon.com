require "sidekiq/web"

Rails.application.routes.draw do

  resources :events do
    scope module: :events do
      resources :teams, only: :index
      resources :entries, only: :index
      resource :rules, only: :show
      resource :leaderboard, only: :show
      resource :resources, only: :show
      resource :winners, only: :show

      resources :votes, only: [:index, :create, :destroy] do
        resource :move, only: [], module: :votes do
          collection do
            patch "up"
            patch "down"
          end
        end
      end
    end
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"

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
    resource :repository_invite, only: [:create], module: :teams
    resources :invitations, module: :teams
  end

  resource :newsletter

  get "/privacy", to: "home#privacy"
  get "/terms", to: "home#terms"
  get "/teams", to: redirect("events/1-hotwire/teams")
  get "/entries", to: redirect("events/1-hotwire/entries")

  get "/votes", to: redirect("events/1-hotwire/votes")
  get "/leaderboard", to: redirect("events/1-hotwire/leaderboard")
  get "/rules", to: redirect("events/1-hotwire/rules")
  get "/resources", to: redirect("events/1-hotwire/resources")
  get "/winners", to: redirect("events/1-hotwire/winners")

  authenticated :user do
    root to: "dashboard#show", as: :authenticated_root
  end

  root to: "home#index"
end
