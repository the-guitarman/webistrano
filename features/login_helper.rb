def login(user)
  visit new_user_session_path
  fill_in "user_login", with: user.login
  fill_in "user_password", with: user.password
  click_button "Sign in"
end