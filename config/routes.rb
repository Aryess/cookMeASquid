Cookmeasquid::Application.routes.draw do
  resources :users
  
  match '/home',    to:'static_pages#home' ,    via: 'get'
  match '/help',    to:'static_pages#help' ,    via: 'get'
  match '/signup',  to:'users#new'         ,    via: 'get'
  root              to:'static_pages#home'
end
