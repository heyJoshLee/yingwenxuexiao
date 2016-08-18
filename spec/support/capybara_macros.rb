
def sign_in(a_user=nil) 
  user = a_user || Fabricate(:user)
  visit sign_in_path
  fill_in "email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_in_unsuccessfuly
  user = Fabricate(:user)
  visit sign_in_path
  fill_in "email", with: user.email + "123"
  fill_in "Password", with: user.password + "123"
  click_button "Sign in"
end

def comment_on_article(article)
  visit article_path(article)
  fill_in "comment_body", with: "This is a great article"
  click_button "Create Comment"
end
