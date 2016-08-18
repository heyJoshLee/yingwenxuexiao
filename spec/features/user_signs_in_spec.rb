require "spec_helper"

feature "User signs in" do

  scenario "successful sign in" do
    sign_in
    expect(page).to have_content("You are signed in.")
  end

  scenario "unsuccessful sign in" do
    sign_in_unsuccessfuly
    expect(page).to have_content("There was something wrong with your email or password.")
  end
end

