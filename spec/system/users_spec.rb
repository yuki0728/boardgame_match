require 'rails_helper'

RSpec.describe "Sign Up", :devise do
  scenario "アカウントの登録が完了する。" do
    sign_up_with("user", "test@example.com", "password", "password")

    texts = [
      I18n.t("devise.registrations.signed_up"),
      I18n.t("devise.registrations.signed_up_but_unconfirmed"),
    ]
    expect(page).to have_content(/.*#{texts[0]}.*|.*#{texts[1]}.*/)
  end

  scenario "ユーザ名が値が入力されていない" do
    sign_up_with("", "test@example.com", "password", "password")

    expect(page).to have_content("ユーザー名が入力されていません。")
  end

  scenario "emailアドレスの値が不正である" do
    sign_up_with("user", "email", "password", "password")

    expect(page).to have_content("メールアドレスは有効でありません。")
  end

  scenario "emailアドレスの値が入力されていない" do
    sign_up_with("user", "", "password", "password")

    expect(page).to have_content("メールアドレスが入力されていません。")
  end

  scenario "パスワードが空である" do
    sign_up_with("user", "test@example.com", "", "")

    expect(page).to have_content("パスワードが入力されていません。")
  end

  scenario "パスワードが６文字以下である" do
    sign_up_with("user", "test@example.com", "1234", "1234")

    expect(page).to have_content("パスワードは6文字以上に設定して下さい。")
  end

  scenario "パスワード(再入力)が空である" do
    sign_up_with("user", "test@example.com", "password", "")

    expect(page).to have_content("確認用パスワードとパスワードの入力が一致しません")
  end

  scenario "パスワードとパスワード(再入力)が違う値である" do
    sign_up_with("user", "test@example.com", "password", "mismatch")

    expect(page).to have_content("確認用パスワードとパスワードの入力が一致しません")
  end
end
