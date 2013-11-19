Cookmeasquid::Application.routes.draw do

  resources :recipes
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  
  match '/home',    to:'static_pages#home'  ,   via: 'get'
  match '/help',    to:'static_pages#help'  ,   via: 'get'
  match '/signup',  to:'users#new'          ,   via: 'get'
  match '/signin',  to:'sessions#new'       ,   via: 'get'
  match '/signout', to:'sessions#destroy'   ,   via: 'delete'
  root              to:'static_pages#home'
end
