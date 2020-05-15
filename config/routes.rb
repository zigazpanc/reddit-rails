Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :pins
  devise_for :accounts, controllers: {omniauth_callbacks: 'omniauth'}
  get "u/:username" => "public#profile", as: :profile
  resources :communities do
    resources :posts
  end

  resources :subscriptions
  resources :comments, only: [:create]
  
  post "post/vote" => "votes#create"

  root to: "public#index"

end
