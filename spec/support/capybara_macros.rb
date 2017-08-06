
def sign_in(a_user=nil) 
  create_starting_levels 
  user = a_user || Fabricate(:user)
  visit sign_in_path
  fill_in "email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def create_starting_levels
  Fabricate(:level, number: 1, points: 100)
  Fabricate(:level, number: 2, points: 1000)
end

def page_should_have(content)
  expect(page).to have_content(content)
end

def page_should_not_have(content)
  expect(page).not_to have_content(content)  
end

def sign_in_unsuccessfuly
  user = Fabricate(:user)
  visit sign_in_path
  fill_in "email", with: user.email + "123"
  fill_in "Password", with: user.password + "123"
  click_button "Sign in"
end

def enroll_in_course(user=nil, course=nil)
  a_course = course || Fabricate(:course, published: true, premium_course: false)
  lesson = Fabricate(:lesson, course_id: a_course.id)
  a_user = user || Fabricate(:user)
  sign_in(a_user)
  visit courses_path
  click_link "報名上課"
end



# https://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara
module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end