Rails.application.routes.draw do
  devise_for :users
  root to: "pages#root"

  resources :pools do
    resources :entries, only: [:create, :show, :update]
    member do
      get "/membership", to: "pools#membership"
      put "/start", to: "pools#start"
    end
  end

  resources :memberships, only: [:index, :create, :destroy]
  resources :questions, only: [:index, :create]
  resources :picks, only: [:index, :create]

  namespace :api do
    namespace :v1 do
      get "/healthcheck", to: "healthcheck#show"
    end
  end
end
