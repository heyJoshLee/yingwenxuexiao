require "spec_helper"

feature "User enrolls in course" do 

  let(:free_user) { Fabricate(:user)}
  let(:paid_user) { Fabricate(:user, membership_level: "paid")}
  let(:premium_course) { Fabricate(:course, published: true, premium_course: true)}

  scenario "not logged in" do
    visit courses_path
    expect(page).to have_content("您必須先登錄才能參加免費課程。")
    expect(page).to have_content("您必須擁有一個高級帳戶才能上高級課程。")
  end

  scenario "free user logged in enrolls into free course" do
    course = Fabricate(:course, published: true, premium_course: false)
    lesson = Fabricate(:lesson, course_id: course.id)
    sign_in(free_user)
    visit courses_path
    expect(page).not_to have_content("您必須先登錄才能參加免費課程。")
    click_link "報名上課"
    visit account_path
    expect(page).to have_content(course.name)
    visit courses_path
    expect(page).not_to have_content("報名上課")    
    expect(page).to have_content("上課")
  end


end