Rails.application.routes.draw do
  get '/posts/index' => 'posts#index'
  get '/posts/new' => 'posts#new'
  post '/posts/create' => 'posts#create'
  get '/posts/:id/edit' => 'posts#edit'
  post '/posts/:id/update' => 'posts#update'
  post '/posts/:id/destroy' => 'posts#destroy'

  get '/posts/:id' => "posts#show"
  
  get({'/' => 'home#top'})
  
  get '/about' => 'home#about' 

  get '/users/index' => 'users#index'
  get '/signup' => 'users#new'
  post '/users/create' => 'users#create'
  get '/users/:id/edit' => 'users#edit'
  post '/users/:id/update' => 'users#update'
  post '/users/:id/destroy' => 'users#destroy'
  get '/users/:id' => 'users#show'
  get '/login' => 'users#login_form'
  post '/login' => 'users#login'
  post '/logout' => 'users#logout'

  post '/likes/:post_id/create' => 'likes#create'
  post '/likes/:post_id/destroy' => 'likes#destroy'
end
