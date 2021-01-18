Rails.application.routes.draw do
  resources :comments
  resources :likes
  resources :blogs
  resources :users
  
  post '/login', to: 'users#login'
  get '/getuser', to: 'users#get_user'
  get '/getlikedblogs', to: 'likes#get_likes'

end
