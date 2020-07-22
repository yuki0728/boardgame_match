Rails.application.routes.draw do
  devise_for :users
  # app/views/devise/shared/_links.html.erb (リンク用パーシャル)
  # app/views/devise/confirmations/new.html.erb (認証メールの再送信画面)
  # app/views/devise/passwords/edit.html.erb (パスワード変更画面)
  # app/views/devise/passwords/new.html.erb (パスワードを忘れた際、メールを送る画面)
  # app/views/devise/registrations/edit.html.erb (ユーザー情報変更画面)
  # app/views/devise/registrations/new.html.erb (ユーザー登録画面)
  # app/views/devise/sessions/new.html.erb (ログイン画面)
  # app/views/devise/unlocks/new.html.erb (ロック解除メール再送信画面)
  # app/views/devise/mailer/confirmation_instructions.html.erb (メール用アカウント認証文)
  # app/views/devise/mailer/password_change.html.erb （メール用パスワード変更完了文）
  # app/views/devise/mailer/reset_password_instructions.html.erb (メール用パスワードリセット文)
  # app/views/devise/mailer/unlock_instructions.html.erb (メール用ロック解除文)
end
