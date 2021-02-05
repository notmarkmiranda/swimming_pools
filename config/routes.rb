Rails.application.routes.draw do
  devise_for :users
  root to: "pages#root"

  resources :pools do
    member do
      get "/membership", to: "pools#membership"
    end
  end

  resources :memberships, only: [:index, :create, :destroy]
end
