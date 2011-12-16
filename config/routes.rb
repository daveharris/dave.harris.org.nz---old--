DaveHarrisOrgNz::Application.routes.draw do
  root :to => "home#index"
  get "home/index"

  resources :posts do
    resources :tags
  end
  match 'blog' => 'posts#index'

  resources :tags
  
  resources :users
  resources :sessions
  get "create_user" => "users#new", :as => "create_user"
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
end
