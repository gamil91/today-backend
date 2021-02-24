Rails.application.routes.draw do

  root 'welcome#index'

  resources :tasks, only: [:create, :update, :destroy]
  resources :lists, only: [:create, :update, :destroy]
  resources :comments, only: [:create, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :blogs, only: [:index, :create, :update, :destroy]
  resources :users, only: [:show, :create, :update, :destroy]
  
  post '/login', to: 'users#login'
  get '/getuser', to: 'users#get_user'
  get '/getlikedblogs', to: 'likes#get_likes'
  get '/getadvice', to: 'application#get_advice'
  post '/updateorder', to: 'tasks#order_tasks'
  post '/updatelistsorder', to: 'lists#order_lists'
  get '/getlists', to: 'lists#get_lists'

  resources :users do
    resources :lists
  end


end
