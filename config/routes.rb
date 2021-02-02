Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    devise_for :users
    resources :songs, only: [:create, :index, :show, :update]
    resources :rhymes, only: [:create, :index, :show, :update, :destroy]
    resources :syllables, only: [:create, :index, :show, :update, :destroy]
    resources :comments, only: [:create, :update, :destroy]
    post "votes", to: "votes#register"
  end
  root to: "static_pages#root"
end
