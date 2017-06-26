Rails.application.routes.draw do
  resource :sessions, only: [:new, :create, :destroy]

  get 'sessions/destroy'

  resources :posts do
    resources :vote_tables
    get '/up', to: "vote_tables#up"
    get '/down', to: "vote_tables#down"
  end

  resources :users do
    resources :posts
  end

  root to: "posts#index"
end
