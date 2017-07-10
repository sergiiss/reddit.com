Rails.application.routes.draw do
  resource :sessions, only: [:new, :create, :destroy]

  get 'sessions/destroy'

  resources :posts do
    resources :votes
    get '/up', to: "votes#up"
    get '/down', to: "votes#down"
  end

  resources :users do
    resources :posts
  end

  root to: "posts#index"
end
