require "spec_helper"

feature "User attempts to subscribe", js: true do
  scenario "Page should have subscription instructions" do
    visit new_subscriber_path
    page_should_have("Subscribe to paid plan")
  end
  scenario "Expired credit card should not work and show error" do
    visit new_subscriber_path
    fill_in 'credit_card_number', with: "4000000000003055"
    fill_in 'exp_month', with:'12'
    fill_in 'exp_year', with:'10'
    fill_in 'card_cvc', with:'232'
    find_button('Subscribe').click
    sleep 10
    page_should_have("Your card's expiration year is invalid.")
  end

  
end
