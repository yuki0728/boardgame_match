Rails.application.routes.draw do
  root 'events#index'
  get '/map_request', to: 'maps#map', as: 'map_request'

  resources :events do
    resources :participations, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :notifications, only: :index do
    collection do
      delete :destroy_all
    end
  end

  resources :maps, only: [:index]

  devise_for :users
  # app/views/users/shared/_links.html.erb (リンク用パーシャル)
  # app/views/users/confirmations/new.html.erb (認証メールの再送信画面)
  # app/views/users/passwords/edit.html.erb (パスワード変更画面)
  # app/views/users/passwords/new.html.erb (パスワードを忘れた際、メールを送る画面)
  # app/views/users/registrations/edit.html.erb (ユーザー情報変更画面)
  # app/views/users/registrations/new.html.erb (ユーザー登録画面)
  # app/views/users/sessions/new.html.erb (ログイン画面)
  # app/views/users/unlocks/new.html.erb (ロック解除メール再送信画面)
  # app/views/users/mailer/confirmation_instructions.html.erb (メール用アカウント認証文)
  # app/views/users/mailer/password_change.html.erb （メール用パスワード変更完了文）
  # app/views/users/mailer/reset_password_instructions.html.erb (メール用パスワードリセット文)
  # app/views/users/mailer/unlock_instructions.html.erb (メール用ロック解除文)

  resources :users, only: [:show]
end
