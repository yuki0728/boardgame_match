module SessionHelpers
  def sign_up_with(username, email, password, confirmation)
    visit new_user_registration_path
    fill_in "user[username]", with: username
    fill_in "user[email]", with: email
    fill_in "user[password]", with: password
    fill_in "user[password_confirmation]", with: confirmation
    click_button I18n.t("users.registrations.new.sign_up")
  end
end
