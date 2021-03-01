require 'rails_helper'

RSpec.describe "Sign In", :devise do
  let(:user) { create(:user) }

  scenario "ログインに失敗する" do
    visit root_path
    click_link 'ログイン', match: :first

    sign_in_with("", "")
    # エラーメッセージが表示される
    expect(page).to have_content(I18n.t("devise.failure.invalid",
                                        authentication_keys: User.human_attribute_name(:email)))
  end

  scenario "ログインに成功する" do
    visit root_path
    click_link 'ログイン', match: :first

    # ログインが成功する
    sign_in_with(user.email, user.password)
    expect(page).to have_content(I18n.t("devise.sessions.signed_in"))
    # ルートパスにリダイレクトする
    expect(current_path).to eq root_path
  end

  scenario "ログアウトする" do
    login_as(user, :scope => :user)
    visit root_path
    # クッキーが作成される
    expect([cookies['remember_token']]).not_to be_empty

    click_link 'ログアウト', match: :first
    # クッキーが削除削除される
    expect([cookies['remember_token']]).to eq [nil]
    # ルートパスにリダイレクトする
    expect(current_path).to eq root_path
  end
end
