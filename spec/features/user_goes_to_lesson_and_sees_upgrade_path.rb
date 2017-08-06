require "spec_helper"

feature "Free users on free lessons see upgrade links and cannot take quizzes" do
  
  scenario "Free users go to a free class to download notes" do
    page_should_have("Free users cannot download class notes. Upgrade to download notes.")
  end

  scenario "Free users go to a free class to comment" do
    page_should_have("Free users cannot ask the teacher questions. Upgrade to ask the teacher questions.")
  end

  scenario "Free users cannot take quizzes" do
    page_should_have("Free users cannot take quizzes. Upgrade to take quizzes.")
  end

  feature "Paid users on any lesson don't see upgrade links" do
  scenario "Paid users go to a premium class to download notes" do
    page_should_not_have("Free users cannot download class notes. Upgrade to download notes.")
  end

  scenario "Paid users go to a premium class to comment" do
    page_should_not_have("Free users cannot ask the teacher questions. Upgrade to ask the teacher questions.")
  end

  scenario "Paid users cannot take quizzes" do
    page_should_not_have("Free users cannot take quizzes. Upgrade to take quizzes.")
  end


  end
end
