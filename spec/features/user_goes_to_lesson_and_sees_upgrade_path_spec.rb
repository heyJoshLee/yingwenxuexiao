require "spec_helper"

feature "Free users on free lessons see upgrade links and cannot take quizzes" do

  scenario "Free user can go to course and lesson" do
    free_user = Fabricate(:user)
    free_course = Fabricate(:course, premium_course: false, published: true)
    free_lesson = Fabricate(:lesson, name: "This Is a Free Lesson!", published: true, course_id: free_course.id)
    vocabulary_word = Fabricate(:vocabulary_word)
    quiz = Fabricate(:quiz, lesson_id: free_lesson.id)

    enroll_in_course(free_user, free_course)
    visit course_path(free_course)
    page_should_have(free_course.name)
    visit course_lesson_path(free_course, free_lesson)
    page_should_have(free_lesson.name)
  end

  context "Free user in free course" do
    let!(:free_user) { Fabricate(:user) }
    let!(:free_course) { Fabricate(:course, premium_course: false, published: true) }
    let!(:free_lesson) { Fabricate(:lesson, name: "This Is a Free Lesson!", published: true, course_id: free_course.id) }
    let!(:vocabulary_word) {Fabricate(:vocabulary_word)}
    let!(:quiz) { Fabricate(:quiz, lesson_id: free_lesson.id)}

    before do
      free_lesson.add_vocabulary_word(vocabulary_word)
      enroll_in_course(free_user, free_course)
      visit course_lesson_path(free_course, free_lesson)
    end

    scenario "Free users can't download class notes notification" do
      # page_should_have("Free users cannot download class notes. Upgrade to download notes.")
      page_should_have("免費用戶無法下載課堂筆記。升級到下載備註。")
    end

    scenario "Free users can't comment on lessons notification" do
      page_should_have("免費用戶不能問老師問題。  爲了問老師問題升級。")
      # page_should_have("Free users cannot ask the teacher questions. Upgrade to ask the teacher questions.")
    end

    scenario "Free users cannot take quizzes" do
      page_should_have("免費用戶無法參加測驗。")
      # page_should_have("Free users cannot take quizzes. Upgrade to take quizzes.")
    end
  end #Free user in free course
  
  context "Premium user in free course" do
    let(:paid_user) { Fabricate(:user, membership_level: "paid") }
    let(:free_course) { Fabricate(:course, premium_course: true, published: true) }
    let(:free_lesson) { Fabricate(:lesson, name: "This Is a Paid Lesson!", published: true, course_id: free_course.id) }
    let(:vocabulary_word_2) {Fabricate(:vocabulary_word)}
    let!(:quiz_2) { Fabricate(:quiz, lesson_id: free_lesson.id)}

    before do
      free_lesson.add_vocabulary_word(vocabulary_word_2)
      enroll_in_course(paid_user, free_course)
      visit course_lesson_path(free_course, free_lesson)
    end

    scenario "Paid users go to a premium class to download notes" do
      page_should_not_have("免費用戶無法下載課堂筆記。升級到下載備註。")
    end

    scenario "Paid users go to a premium class to comment" do
      page_should_not_have("免費用戶不能問老師問題。  爲了問老師問題升級。")
    end

    scenario "Paid users cannot take quizzes" do
      page_should_not_have("免費用戶無法參加測驗。")
    end

  end # Premium user in premium course


  context "Premium user in premium course" do
    let(:paid_user) { Fabricate(:user, membership_level: "paid") }
    let(:paid_course) { Fabricate(:course, premium_course: true, published: true) }
    let(:paid_lesson) { Fabricate(:lesson, name: "This Is a Paid Lesson!", published: true, course_id: paid_course.id) }
    let(:vocabulary_word_2) {Fabricate(:vocabulary_word)}
    let!(:quiz_2) { Fabricate(:quiz, lesson_id: paid_lesson.id)}

    before do
      paid_lesson.add_vocabulary_word(vocabulary_word_2)
      enroll_in_course(paid_user, paid_course)
      visit course_lesson_path(paid_course, paid_lesson)
    end

    scenario "Paid users go to a premium class to download notes" do
      page_should_not_have("免費用戶無法下載課堂筆記。升級到下載備註。")
    end

    scenario "Paid users go to a premium class to comment" do
      page_should_not_have("免費用戶不能問老師問題。  爲了問老師問題升級。")
    end

    scenario "Paid users cannot take quizzes" do
      page_should_not_have("免費用戶無法參加測驗。")
    end

  end # Premium user in premium course


end
