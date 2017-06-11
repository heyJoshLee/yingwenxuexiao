require "spec_helper"

feature "User resets password" do

  scenario "user successfully resets the password" do
    alice = Fabricate(:user, password: "old_password")

    go_to_forgot_password_page_and_fill_out_form(alice.email)
    open_email(alice.email)

    current_email.click_link("Reset password")

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"
    
    visit sign_in_path
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: "new_password"
    click_button "Sign in"

    page_should_have("您已登入")
    clear_email
  end

  scenario "User doesn't enter an email address" do
    alice = Fabricate(:user, password: "old_password")
    go_to_forgot_password_page_and_fill_out_form("")
    page_should_have("Email cannot be blank.")
    clear_email
  end

  scenario "User enters an email that doesn't exist" do
    go_to_forgot_password_page_and_fill_out_form("not_a_real_email@yahoo.com")
    page_should_have("Cannot find email.")
  end
end

def go_to_forgot_password_page_and_fill_out_form(email)
    visit sign_in_path
    click_link "忘記密碼"
    # click_link "Forgot Password"
    fill_in "Email Address", with: email
    click_button "Send Password Reset Email"
end