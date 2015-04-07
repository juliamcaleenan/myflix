Myflix::Application.routes.draw do
  root to: 'welcome#index'

  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'videos#index'
  get '/register', to: 'users#new'
  get '/sign-in', to: 'sessions#new'
  post '/sign-in', to: 'sessions#create'
  get '/sign-out', to: 'sessions#destroy'
  get '/my-queue', to: 'queue_items#index'
  post '/update_queue', to: 'queue_items#update_queue'
  
  resources :videos, only: [:show] do
    collection do
      get 'search'
    end
    resources :reviews, only: [:create]
  end
  resources :categories, only: [:show]
  resources :users, only: [:create]
  resources :queue_items, only: [:create, :destroy]

end