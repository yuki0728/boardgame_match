require 'rails_helper'

describe 'users_edit', type: :system do
  let(:user) { create(:user) }

  scenario 'プロフィール変更ができる' do
    login_as(user, :scope => :user)

    expect do
      visit root_path
      click_link 'プロフィール変更', match: :first

      edit_profile_with('user', 'test@example.com', 'profile', 'spec/fixtures/user_sample.jpg')

      expect(page).to have_content(I18n.t("devise.registrations.updated"))
      # ルートパスにリダイレクトする
      expect(current_path).to eq user_path(user.id)
    end.to change(User, :count).by(0) # ユーザの数は変わらない
  end
end
