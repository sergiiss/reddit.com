Rails.application.routes.draw do
  resource :sessions, only: [:new, :create, :destroy]

  get 'sessions/destroy'

  resources :posts do
    resources :votes
    resources :vote_downs
  end

  resources :users do
    resources :posts
  end



  root to: "posts#index"
end
