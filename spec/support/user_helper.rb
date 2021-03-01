module UserHelpers
  def sign_up_with(username, email, password, confirmation)
    fill_in "user[username]", with: username
    fill_in "user[email]", with: email
    fill_in "user[password]", with: password
    if image.nil?
    fill_in "user[password_confirmation]", with: confirmation
    end
    click_button I18n.t("users.registrations.new.sign_up")
  end

  def sign_in_with(email, password)
    fill_in "user[email]", with: email
    fill_in "user[password]", with: password
    click_button I18n.t("users.sessions.new.sign_in")
  end

  def edit_profile_with(username, email, profile, image)
    fill_in "user[username]", with: username
    fill_in "user[email]", with: email
    fill_in "user[profile]", with: profile

    if image.nil?
      attach_file('user[img]', File.join(Rails.root, image))
    end
    click_button I18n.t("users.registrations.edit.update")
  end

  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end
end
