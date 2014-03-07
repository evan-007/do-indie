module LoginMacros
  
  def sign_in(user)
    visit new_user_session_en_path
    fill_in "user[username]", with: user.username
    fill_in "user[password]", with: user.password
    click_button "Sign in"
  end
end