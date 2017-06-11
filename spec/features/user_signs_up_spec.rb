require "spec_helper"

feature "User signs up" do
  
  scenario "successful sign up" do
    sign_up
    expect(page).to have_content("您已成功註冊。您現在已經登錄。")
    # expect(page).to have_content("You have successfully registered. You are now logged in.")
  end

  scenario "user signs up with a free account with affiliate link and is associated with the link" do
    affiliate = Fabricate(:affiliate)
    affiliate_link = Fabricate(:affiliate_link, slug: "abc123", affiliate_id: affiliate.id)
    visit "/signup/abc123"
    fill_in "user_email", with: "Johnsmith@google.com"
    fill_in "user_name", with: "Dr. John Smith"
    fill_in "user_password", with: "neatpassword123"
    click_button "Sign Up"
    expect(User.last.affiliate_link_id).to eq(affiliate_link.id)
  end

  scenario "user tries to upgrade without having an account" do
    visit upgrade_path
    expect(page).to have_content("Sign up now")
  end

  scenario "unsuccessful sign up" do
    sign_up_unsuccessfuly
    expect(page).to have_content("您的帳戶未創建。")
    # expect(page).to have_content("Your account was not created.")
  end
end

def sign_up
  visit sign_out_path
  visit sign_up_path
  fill_in "user_email", with: "Johnsmith@google.com"
  fill_in "user_name", with: "Dr. John Smith"
  fill_in "user_password", with: "neatpassword123"
  click_button "Sign Up"
end

def sign_up_unsuccessfuly
  visit sign_out_path
  visit sign_up_path
  fill_in "user_email", with: "Johns@.com"
  fill_in "user_name", with: "D"
  click_button "Sign Up"
end


