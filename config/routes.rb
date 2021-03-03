Rails.application.routes.draw do
  root 'home#top'

  # google-map
  resources :maps, only: [:index]
  get '/map_request', to: 'maps#map', as: 'map_request'

  # イベント
  resources :events do
    resources :participations, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  # 通知
  resources :notifications, only: :index do
    collection do
      delete :destroy_all
    end
  end

  # ユーザ
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    get 'users/:id/following', to: 'users/registrations#following', as: 'following'
    get 'users/:id/followers', to: 'users/registrations#followers', as: 'followers'
  end

  resources :users, only: [:show]
  resources :relationships, only: [:create, :destroy]
end
