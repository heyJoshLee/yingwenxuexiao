require "spec_helper"

feature "User comments on article" do

  scenario "successful comment", {js: true} do
    user = Fabricate(:user, name: "John Smith")
    article = Fabricate(:article)
    sign_in(user)
    comment_on_article(article)
    expect(page).to have_content("This is a great article")
    expect(page).to have_content("John Smith says")
  end

  scenario "unsuccessful comment" do
    user = Fabricate(:user, name: "John Smith")
    sign_in(user)
    article = Fabricate(:article)
    visit article_path(article)
    click_button "Create Comment"
    expect(page).to not_have_content("This is a great article")
    expect(page).to not_have_content("John Smith says")
  end

  scenario "user not logged in" do
    article = Fabricate(:article)
    visit article_path(article)
    expect(page).to have_content("You need to be signed in to write a comment")
  end

end
