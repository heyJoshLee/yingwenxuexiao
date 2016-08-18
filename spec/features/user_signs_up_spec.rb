require "spec_helper"

feature "User signs up" do
  
  scenario "successful sign up" do
    sign_up
    expect(page).to have_content("You have successfully registered. You are now logged in.")
  end

  scenario "unsuccessful sign up" do
    sign_up_unsuccessfuly
    expect(page).to have_content("Your account was not created.")
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


