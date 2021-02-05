Rails.application.routes.draw do
  devise_for :users
  root to: "pages#root"

  resources :pools do
    member do
      get "/membership", to: "pools#membership"
    end
  end

  # get "/memberships", to: "memberships#index"
  # post "/memberships", to: "memberships#create"
  # delete "/membership/:id", to: "memberships#destroy"
  resources :memberships, only: [:index, :create, :destroy]
end
