Rails.application.routes.draw do
  resources :reviews
  
  resources :posts, except: [:show] do
    resources :reviews, only: [:create] # Nested route for creating reviews under posts
  end

  resources :users do
    resources :posts, only: [:index]
  end

  post '/posts', to: 'posts#create'

  get '/posts/top', to: 'posts#top'
  
  root "users#index"
end
