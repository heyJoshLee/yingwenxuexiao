require "spec_helper"

feature "User enrolls in course" do

  scenario "successful enrollment" do
    user = Fabricate(:user, membership_level: "paid")
    course = Fabricate(:course, published: true)
    sign_in(user)
    visit courses_path
    click_link "Enroll In Class"
    visit account_path
    expect(page).to have_content(course.name)
    visit courses_path
    expect(page).not_to have_content("Enroll In Class")
    expect(page).to have_content("Go to class")
  end

  scenario "not logged in" do
    course = Fabricate(:course)
    visit courses_path
    expect(page).not_to have_content("Enroll In Class")
  end

  scenario "not paid member" do
    user = Fabricate(:user, membership_level: "free")
    course = Fabricate(:course)
    sign_in(user)
    visit courses_path
    expect(page).to have_content("需要使用付費帳號才能參加課程")
    expect(page).not_to have_content("Enroll In Class")
  end



end