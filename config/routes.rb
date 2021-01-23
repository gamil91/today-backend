Rails.application.routes.draw do
  resources :tasks
  resources :lists
  resources :comments
  resources :likes
  resources :blogs
  resources :users
  
  post '/login', to: 'users#login'
  get '/getuser', to: 'users#get_user'
  get '/getlikedblogs', to: 'likes#get_likes'
  get '/getadvice', to: 'application#get_advice'

end
