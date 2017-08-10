shared_examples_for "requires sign in" do
  it "redirect to the sign in page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to sign_in_path
  end
end

shared_examples_for "free user signs in but requires premium member" do
  it "redirect to the upgrade page" do
    session[:user_id] = nil
    sign_in_free_member
    action
    expect(response).to redirect_to upgrade_path
  end
end


shared_examples_for "unpublished course or lesson for free" do
  it "redirects to courses path" do
    action
    expect(response).to redirect_to courses_path
  end
end

shared_examples_for "unpublished course or lesson for paid" do
  it "redirects to courses path" do
    action
    expect(response).to redirect_to courses_path
  end

end