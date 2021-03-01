require 'rails_helper'

RSpec.describe "Sign Up", :devise do
  scenario "アカウントの登録が失敗する" do
    visit root_path
    click_link 'サインアップ', match: :first
    expect do
      sign_up_with("", "", "", "")
    end.to change(User, :count).by(0) # ユーザ数が増えない
  end

  scenario "アカウントの登録が完了する" do
    visit root_path
    click_link 'サインアップ', match: :first
    expect do
      sign_up_with("user", "test@example.com", "password", "password")

      texts = [
        I18n.t("devise.registrations.signed_up"),
        I18n.t("devise.registrations.signed_up_but_unconfirmed"),
      ]
      # メールの確認を促される
      expect(page).to have_content(/.*#{texts[0]}.*|.*#{texts[1]}.*/)
    end.to change(User, :count).by(1) # ユーザ数が一人増える

    # アカウント認証メールが届く
    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url
    # メールアドレスが確認される
    expect(page).to have_content(I18n.t("devise.confirmations.confirmed"))
    # ログインページにリダイレクトする
    expect(current_path).to eq new_user_session_path

    # ログインが成功する
    sign_in_with("test@example.com", "password")
    expect(page).to have_content(I18n.t("devise.sessions.signed_in"))
    # ルートパスにリダイレクトする
    expect(current_path).to eq root_path
  end
end
