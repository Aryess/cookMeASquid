Cookmeasquid::Application.routes.draw do
  get "users/new"

  match '/home',    to:'static_pages#home' ,    via: 'get'
  match '/help',    to:'static_pages#help' ,    via: 'get'
  root              to:'static_pages#home'
end
