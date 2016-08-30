require "spec_helper"

describe User do

  describe "#is_paid_member?" do
    it "returns false if user is a free member" do
      user = Fabricate(:user, membership_level: "free")
      expect(user.is_paid_member?).to be_falsey
    end

    it "returns true if user is a paid member" do
      user = Fabricate(:user, membership_level: "paid")
      expect(user.is_paid_member?).to be_truthy
    end
  end

  describe "#is_editor?" do

    it "should return true when user is an editor" do
      user = Fabricate(:user, role: "editor")
      expect(user.is_editor?).to be_truthy
    end

    it "should return false when user is a regular user" do
      user = Fabricate(:user)
      expect(user.is_editor?).to be_falsey
    end

    it "should return false when user is an admin" do
      user = Fabricate(:user, role: "admin")
      expect(user.is_editor?).to be_falsey
    end
  end # is_editor?

  describe "#is_admin?" do

    it "should return true when user is an admin" do
      user = Fabricate(:user, role: "admin")
      expect(user.is_admin?).to be_truthy
    end

    it "should return false when user is a regular user" do
      user = Fabricate(:user)
      expect(user.is_admin?).to be_falsey
    end

    it "should return false when user is an admin" do
      user = Fabricate(:user, role: "editor")
      expect(user.is_admin?).to be_falsey
    end
  end # is_admin?

  describe "#is_enrolled_in?" do
    let(:user) { Fabricate(:user) }
    let(:course) { Fabricate(:course) }

    it "should return false if user is not enrolled in the course" do
      expect(user.is_enrolled_in?(course)).to be_falsey
    end

    it "should return true id user is enrolled in the course" do
      user.enroll_in(course)
      expect(user.is_enrolled_in?(course)).to be_truthy
    end
  end

  describe "#taken_quiz?(quiz)" do
    let(:quiz) { Fabricate(:quiz) }
    let(:user) { Fabricate(:user) }

    let(:question) { Fabricate(:question, quiz_id: quiz.id) }
    let(:choice) { Fabricate(:choice, question_id: question.id) }

    it "returns false if user hasn't taken the quiz" do
      expect(user.taken_quiz?(quiz)).to be_falsey
    end

    it "returns true if user has taken the quiz" do
      user.attempt_quiz(quiz, [[question, choice]] )
      expect(user.taken_quiz?(quiz)).to be_truthy
    end
  end

  describe "#complete_lesson(lesson)" do
    let(:user) { Fabricate(:user) }
    let(:lesson) { Fabricate(:lesson) }

    it "should create a lesson_user object if the user has not completed the lesson" do
      user.complete_lesson(lesson)
      expect(LessonUser.count).to eq(1)
    end
    it "should not create a lesson_user object if the user has already completed the lesson" do
      user.complete_lesson(lesson)
      user.complete_lesson(lesson)
      expect(LessonUser.count).to eq(1)
    end
  end

  describe "#completed_lesson?(lesson)" do
    let(:user) { Fabricate(:user) }
    let(:lesson) { Fabricate(:lesson) }

    it "should return false if user hasn't completed the lesson" do
      expect(user.completed_lesson?(lesson)).to be_falsey
    end

    it "should return true if user has completed the lesson" do
      user.complete_lesson(lesson)
      expect(user.completed_lesson?(lesson)).to be_truthy
    end
  end

  describe "#answer_question(question, choice)" do
    let(:quiz) { Fabricate(:quiz) }
    let(:question) { Fabricate(:question, quiz_id: quiz.id) }
    let(:choice) { Fabricate(:choice, question_id: question.id) }
    let(:user) { Fabricate(:user) }

    before do
      user.answer_question(question, choice)
    end

    it "creates a user_question with valid inputs" do
      expect(UserQuestion.count).to eq(1)
    end

    it "creates a user_question linked to the question and user" do
      expect(user.answered_questions.first).to eq(UserQuestion.first)
    end

    it "does not create a new UserQuestion object if the user has already answered the question" do
      choice_2 = Fabricate(:choice, question_id: question.id)
      user.answer_question(question, choice_2)
      expect(UserQuestion.count).to eq(1)
    end

    it "changes the answer choice" do
      choice_2 = Fabricate(:choice, question_id: question.id)
      user.answer_question(question, choice_2)
      expect(UserQuestion.first.choice_id).to eq(choice_2.id)

    end
  end

  describe "#selected_choice?(choice)" do
    let(:user) { Fabricate(:user) }

    let(:quiz) { Fabricate(:quiz) }

    let(:question_1) { Fabricate(:question, quiz_id: quiz.id) }

    let(:choice_1) { Fabricate(:choice, question_id: question_1.id) }

    let(:choice_2) { Fabricate(:choice, question_id: question_1.id) }

    before do
      user.answer_question(question_1, choice_1)
    end

    it "returns false if user has not selected this choice for a question" do
      expect(user.selected_choice?(choice_2)).to be_falsey
    end

    it "returns true if user has selected this choice for a question" do
      expect(user.selected_choice?(choice_1)).to be_truthy
    end
  end

  describe "#attempt_quiz(quiz, question_and_answer_array)" do
    let(:user) { Fabricate(:user) }
    let(:quiz) { Fabricate(:quiz) }

    let(:question_1) { Fabricate(:question, quiz_id: quiz.id) }
    let(:choice_1) { Fabricate(:choice, question_id: question_1.id) }
    let(:question_2)  { Fabricate(:question, quiz_id: quiz.id) }
    let(:choice_2)    { Fabricate(:choice, question_id: question_2.id) }
    let(:question_3)  { Fabricate(:question, quiz_id: quiz.id) }
    let(:choice_3)   { Fabricate(:choice, question_id: question_3.id) }

    it "creates a user_quiz when user attempts a quiz with one question" do
      user.attempt_quiz(quiz, [
        [question_1, choice_1]
      ])
      expect(UserQuestion.count).to eq(1);
      expect(UserQuiz.count).to eq(1);
    end

    it "creates a user_question for each question and answer for a quiz with three questions" do

      user.attempt_quiz(quiz, [
        [question_1, choice_1],
        [question_2, choice_2],
        [question_3, choice_3]
      ])
      expect(user.questions.count).to eq(3)
      expect(user.quizzes.count).to eq(1)
    end

    it "doesn't create multiple user quizzes when a quiz is taken more than once" do
      user.attempt_quiz(quiz, [
        [question_1, choice_1]
      ])
      user.attempt_quiz(quiz, [
        [question_2, choice_2]
      ])

      expect(user.quizzes.count).to eq(1)
    end
  end

  describe "#answered_question?(question)" do
    let(:user) { Fabricate(:user) }
    let(:quiz) { Fabricate(:quiz) }
    let(:question) { Fabricate(:question) }
    let(:choice) { Fabricate(:choice, question_id: question.id) }

    it "returns false if user hasn't answered the question" do
      expect(user.answered_question?(question)).to be_falsey
    end

    it "returns true if user has answered the question" do
      user.answer_question(question, choice)
      expect(user.answered_question?(question)).to be_truthy
    end
  end

  describe "#answered_correctly?(question)" do
    let(:user) { Fabricate(:user) }
    let(:quiz) { Fabricate(:quiz) }
    let(:question) { Fabricate(:question) }

    it "returns false if user has not answered the question" do
      expect(user.answered_correctly?(question)).to be_falsey
    end

    it "returns false if user has answered the question incorrectly" do
      choice = Fabricate(:choice, question_id: question.id, correct: false)
      user.answer_question(question, choice)
      expect(user.answered_correctly?(question)).to be_falsey
    end
    it "returns true if user has answered the question correctly" do
      choice = Fabricate(:choice, question_id: question.id, correct: true)
      user.answer_question(question, choice)
      expect(user.answered_correctly?(question)).to be_truthy
    end
  end

  describe "#answer_points" do
    let(:user) { Fabricate(:user) }
    let(:quiz) { Fabricate(:quiz) }
    let(:question) { Fabricate(:question) }

    it "returns 0 if user has not answered the question" do
      expect(user.answer_points(question)).to eq(0)
    end

    it "returns 0 if user answered the question wrong" do
      choice = Fabricate(:choice, correct: false)
      user.answer_question(question, choice)
      expect(user.answer_points(question)).to eq(0)
    end

    it "returns the point value if user answered the question correctly" do
      choice = Fabricate(:choice, correct: true)
      user.answer_question(question, choice)
      expect(user.answer_points(question)).to eq(question.value)
    end
  end

  describe "#quiz_score(quiz)" do
    let(:user) { Fabricate(:user) }
    let(:quiz_1) { Fabricate(:quiz) }


    let(:correct_question_1) { Fabricate(:question, quiz_id: quiz_1.id, value: 20) }
    let(:correct_choice_1) { Fabricate(:choice, question_id: correct_question_1.id, correct: true) }

    let(:correct_question_2) { Fabricate(:question, quiz_id: quiz_1.id, value: 20) }
    let(:correct_choice_2) { Fabricate(:choice, question_id: correct_question_2.id, correct: true) }

    let(:correct_question_3) { Fabricate(:question, quiz_id: quiz_1.id, value: 20) }
    let(:correct_choice_3) { Fabricate(:choice, question_id: correct_question_3.id, correct: true) }

    let(:incorrect_question_1) { Fabricate(:question, quiz_id: quiz_1.id, value: 20) }
    let(:incorrect_choice_1) { Fabricate(:choice, question_id: incorrect_question_1.id, correct: false) }

    let(:incorrect_question_2) { Fabricate(:question, quiz_id: quiz_1.id, value: 20) }
    let(:incorrect_choice_2) { Fabricate(:choice, question_id: incorrect_question_2.id, correct: false) }

    let(:incorrect_question_3) { Fabricate(:question, quiz_id: quiz_1.id, value: 20) }
    let(:incorrect_choice_3) { Fabricate(:choice, question_id: incorrect_question_3.id, correct: false) }


    it "returns 0 if user hasn't taken the quiz" do
      expect(user.quiz_score(quiz_1)).to eq(0)
    end

    it "returns 1 is user has answered all the questions correctly" do
      aced_quiz = Fabricate(:quiz)
      question_1 = Fabricate(:question, quiz_id: aced_quiz.id, value: 10)
      correct_choice_1 = Fabricate(:choice, question_id: question_1.id, correct: true)

      user.attempt_quiz(aced_quiz, [[question_1, correct_choice_1]])

      expect(user.quiz_score(aced_quiz)).to eq(1.00)
    end

    it "returns a decimal from 0 - 1 if the user has taken the quiz" do
      user.attempt_quiz(quiz_1,[
          [correct_question_1, correct_choice_1],
          [correct_question_2, correct_choice_2],
          [correct_question_3, correct_choice_3],
          [incorrect_question_1, incorrect_choice_1],
          [incorrect_question_2, incorrect_choice_2],
          [incorrect_question_3, incorrect_choice_3]
        ]
      )
      expect(user.quiz_score(quiz_1)).to eq(0.50)
    end
  end

  describe "#attempted_quizzes" do
    let(:user) { Fabricate(:user) }
    let(:quiz) { Fabricate(:quiz) }

    let(:correct_question_1) { Fabricate(:question, quiz_id: quiz.id) }
    let(:correct_choice_1) { Fabricate(:choice, question_id: correct_question_1.id, correct: true) }

    let(:correct_question_2) { Fabricate(:question, quiz_id: quiz.id) }
    let(:correct_choice_2) { Fabricate(:choice, question_id: correct_question_2.id, correct: true) }

    let(:correct_question_3) { Fabricate(:question, quiz_id: quiz.id) }
    let(:correct_choice_3) { Fabricate(:choice, question_id: correct_question_3.id, correct: true) }

    let(:incorrect_question_1) { Fabricate(:question, quiz_id: quiz.id) }
    let(:incorrect_choice_1) { Fabricate(:choice, question_id: incorrect_question_1.id) }

    let(:incorrect_question_2) { Fabricate(:question, quiz_id: quiz.id) }
    let(:incorrect_choice_2) { Fabricate(:choice, question_id: incorrect_question_2.id) }

    let(:incorrect_question_3) { Fabricate(:question, quiz_id: quiz.id) }
    let(:incorrect_choice_3) { Fabricate(:choice, question_id: incorrect_question_3.id) }

    it "returns an array of user_quiz objects" do
      user.attempt_quiz(quiz,[
          [correct_question_1, correct_choice_1],
          [correct_question_2, correct_choice_2],
          [correct_question_3, correct_choice_3],
          [incorrect_question_1, incorrect_choice_1],
          [incorrect_question_2, incorrect_choice_2],
          [incorrect_question_3, incorrect_choice_3]
        ]
      )
      expect(user.attempted_quizzes.count).to eq(1)
    end
  end

  describe "#next_lesson_in_course(course)" do
    let(:user) { Fabricate(:user) }
    let(:course) { Fabricate(:course, name: "Business English", id: 1) }

    
      let!(:lesson_1) { Fabricate(:lesson, course_id: 1, lesson_number: 1) }
      let!(:lesson_2) { Fabricate(:lesson, course_id: 1, lesson_number: 2) }
      let!(:lesson_3) { Fabricate(:lesson, course_id: 1, lesson_number: 3) }
      let!(:lesson_4) { Fabricate(:lesson, course_id: 1, lesson_number: 4) }


    it "should return the first lesson if the user is not enrolled in course" do
      expect(user.next_lesson_in_course(course)).to eq(course.lessons.first)
    end

    it "should return return the second lesson in the course if user has only completed the first lesson" do
      user.enroll_in(course)
      user.complete_lesson(course.lessons.first)
      expect(user.next_lesson_in_course(course)).to eq(course.lessons[1])
    end

    it "should return the first lesson if the user has completed the second lesson" do
      user.enroll_in(course)
      user.complete_lesson(course.lessons[1])
      expect(user.next_lesson_in_course(course)).to eq(course.lessons.first)
    end

    it "should return the last lesson if the user has completed all the lessons" do
      user.enroll_in(course)
      user.complete_lesson(course.lessons[0])
      user.complete_lesson(course.lessons[1])
      user.complete_lesson(course.lessons[2])
      user.complete_lesson(course.lessons[3])

      expect(user.next_lesson_in_course(course)).to eq(course.lessons.last)
    end
  end

  describe "#add_points(points)" do
    let!(:user) { Fabricate(:user) }
    let!(:level_1) { Fabricate(:level, number: 1, points: 100) }
    let!(:level_2) { Fabricate(:level, number: 2, points: 200) }

    it "adds 100 to user" do
      user.add_points(100)
      expect(user.points).to eq(100)
    end

    it "adds 55 and then 100 points to user" do
      user.add_points(55)
      user.add_points(100)
      expect(user.points).to eq(155)
    end
  end

  describe "#advance_level_if_enough_points" do
    let(:user) { Fabricate(:user) }

      let!(:level_1){  Fabricate(:level, points: 0, number: 1) }
      let!(:level_2){  Fabricate(:level, points: 100, number: 2) }
      let!(:level_3){  Fabricate(:level, points: 200, number: 3) }

    it "doesn't advance the level if the user doesn't get enough points" do
      user.add_points(40)
      expect(user.level).to eq(1)
    end

    it "advances the level by one if the user earns enough points to advance" do
      user.add_points(150)
      expect(user.level).to eq(2)
    end
  end

  describe "#add_vocabulary_word(word)" do
    let(:user) { Fabricate(:user) }
    let(:vocabulary_word_1) { Fabricate(:vocabulary_word) }
    let(:vocabulary_word_2) { Fabricate(:vocabulary_word) }

    it "adds vocabulary word to users words" do
      user.add_vocabulary_word(vocabulary_word_1)
      expect(user.vocabulary_words.first).to eq(vocabulary_word_1)
    end

    it "adds another vocabulary word to a users words " do
      user.add_vocabulary_word(vocabulary_word_1)
      user.add_vocabulary_word(vocabulary_word_2)
      expect(user.vocabulary_words.count).to eq(2)
    end

    it "doesn't add the word if the user already has the word in his list" do
      user.add_vocabulary_word(vocabulary_word_1)
      user.add_vocabulary_word(vocabulary_word_1)
      expect(user.vocabulary_words.count).to eq(1)
    end
  end

  describe "#practice(type, word, answer)" do
    let(:user) { Fabricate(:user) }
    let(:vocabulary_word) { Fabricate(:vocabulary_word, main: "hello", chinese: "好", definition: "a phrase used when greeting someone.") }
    let!(:level_1) { Fabricate(:level, number: 1, points: 0) }
    let!(:level_2) { Fabricate(:level, number: 2, points: 100) }

    before do
      user.add_vocabulary_word(vocabulary_word)
    end

    it "adds points to the user if the user gets the correct answer" do
      correct_answer =  vocabulary_word.main
      user.practice(:chinese_to_english, vocabulary_word, correct_answer)
      expect(user.points).to eq(10)
    end

    it "doesn't add points to the user if the  user get the incorrect answer" do
      incorrect_answer =  vocabulary_word.main + "123"
      user.practice(:chinese_to_english, vocabulary_word, incorrect_answer)
      expect(user.points).to eq(0)
    end

    context "practicing English to Chinese" do

      let(:correct_answer_1) { vocabulary_word.chinese }
      let(:incorrect_answer_1) { vocabulary_word.chinese + "123" }
      let(:incorrect_answer_2) { vocabulary_word.chinese + "abc" }

      it "adds one to english_to_chinese_attempted" do
        user.practice(:english_to_chinese, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.english_to_chinese_attempted).to eq(1)
      end

      it "doesn't add 1 to correct if the answer is not correct" do
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.english_to_chinese_correct).to eq(0)
      end

      it "adds 1 to correct if the answer is correct" do 
        user.practice(:english_to_chinese, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.english_to_chinese_correct).to eq(1)
      end

      it  "works if user answers correctly twice in a row" do
        user.practice(:english_to_chinese, vocabulary_word, correct_answer_1)
        user.practice(:english_to_chinese, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.english_to_chinese_correct).to eq(2)
        expect(user.user_vocabulary_words.first.english_to_chinese_attempted).to eq(2)
      end

      it "works with a mix of correct and incorrect answers" do
        user.practice(:english_to_chinese, vocabulary_word, correct_answer_1)
        user.practice(:english_to_chinese, vocabulary_word, correct_answer_1)
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_1)
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.english_to_chinese_correct).to eq(2)
        expect(user.user_vocabulary_words.first.english_to_chinese_attempted).to eq(4)
      end

      it "works with a mix of more correct and incorrect answers" do
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_1)
        user.practice(:english_to_chinese, vocabulary_word, correct_answer_1)
        user.practice(:english_to_chinese, vocabulary_word, correct_answer_1)
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_1)
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_2)
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_2)
        user.practice(:english_to_chinese, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.english_to_chinese_correct).to eq(3)
        expect(user.user_vocabulary_words.first.english_to_chinese_attempted).to eq(7)
      end

      it "works with many incorrect answers" do
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_1)
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_2)
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_2)
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_2)
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_1)
        user.practice(:english_to_chinese, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.english_to_chinese_correct).to eq(0)
        expect(user.user_vocabulary_words.first.english_to_chinese_attempted).to eq(6)
      end
    end # practicing English to Chinese

    context "practicing Chinese to English" do

      let(:correct_answer_1) { vocabulary_word.main }
      let(:incorrect_answer_1) { vocabulary_word.main + "123" }
      let(:incorrect_answer_2) { vocabulary_word.main + "abc" }

      it "adds one to chinese_to_english_attempted" do
        user.practice(:chinese_to_english, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.chinese_to_english_attempted).to eq(1)
      end

      it "doesn't add 1 to correct if the answer is not correct" do
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.chinese_to_english_correct).to eq(0)
      end

      it "adds 1 to correct if the answer is correct" do 
        user.practice(:chinese_to_english, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.chinese_to_english_correct).to eq(1)
      end

      it  "works if user answers correctly twice in a row" do
        user.practice(:chinese_to_english, vocabulary_word, correct_answer_1)
        user.practice(:chinese_to_english, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.chinese_to_english_correct).to eq(2)
        expect(user.user_vocabulary_words.first.chinese_to_english_attempted).to eq(2)
      end

      it "works with a mix of correct and incorrect answers" do
        user.practice(:chinese_to_english, vocabulary_word, correct_answer_1)
        user.practice(:chinese_to_english, vocabulary_word, correct_answer_1)
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_1)
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.chinese_to_english_correct).to eq(2)
        expect(user.user_vocabulary_words.first.chinese_to_english_attempted).to eq(4)
      end

      it "works with a mix of more correct and incorrect answers" do
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_1)
        user.practice(:chinese_to_english, vocabulary_word, correct_answer_1)
        user.practice(:chinese_to_english, vocabulary_word, correct_answer_1)
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_1)
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_2)
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_2)
        user.practice(:chinese_to_english, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.chinese_to_english_correct).to eq(3)
        expect(user.user_vocabulary_words.first.chinese_to_english_attempted).to eq(7)
      end

      it "works with many incorrect answers" do
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_1)
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_2)
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_2)
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_2)
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_1)
        user.practice(:chinese_to_english, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.chinese_to_english_correct).to eq(0)
        expect(user.user_vocabulary_words.first.chinese_to_english_attempted).to eq(6)
      end
    end # practicing Chinese to English

    context "practicing definition" do

      let(:correct_answer_1) { vocabulary_word.definition }
      let(:incorrect_answer_1) { vocabulary_word.definition + "123" }
      let(:incorrect_answer_2) { vocabulary_word.definition + "abc" }

      it "adds one to chinese_to_english_attempted" do
        user.practice(:definition, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.definition_attempted).to eq(1)
      end

      it "doesn't add 1 to correct if the answer is not correct" do
        user.practice(:definition, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.definition_correct).to eq(0)
      end

      it "adds 1 to correct if the answer is correct" do 
        user.practice(:definition, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.definition_correct).to eq(1)
      end

      it  "works if user answers correctly twice in a row" do
        user.practice(:definition, vocabulary_word, correct_answer_1)
        user.practice(:definition, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.definition_correct).to eq(2)
        expect(user.user_vocabulary_words.first.definition_attempted).to eq(2)
      end

      it "works with a mix of correct and incorrect answers" do
        user.practice(:definition, vocabulary_word, correct_answer_1)
        user.practice(:definition, vocabulary_word, correct_answer_1)
        user.practice(:definition, vocabulary_word, incorrect_answer_1)
        user.practice(:definition, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.definition_correct).to eq(2)
        expect(user.user_vocabulary_words.first.definition_attempted).to eq(4)
      end

      it "works with a mix of more correct and incorrect answers" do
        user.practice(:definition, vocabulary_word, incorrect_answer_1)
        user.practice(:definition, vocabulary_word, correct_answer_1)
        user.practice(:definition, vocabulary_word, correct_answer_1)
        user.practice(:definition, vocabulary_word, incorrect_answer_1)
        user.practice(:definition, vocabulary_word, incorrect_answer_2)
        user.practice(:definition, vocabulary_word, incorrect_answer_2)
        user.practice(:definition, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.definition_correct).to eq(3)
        expect(user.user_vocabulary_words.first.definition_attempted).to eq(7)
      end

      it "works with many incorrect answers" do
        user.practice(:definition, vocabulary_word, incorrect_answer_1)
        user.practice(:definition, vocabulary_word, incorrect_answer_2)
        user.practice(:definition, vocabulary_word, incorrect_answer_2)
        user.practice(:definition, vocabulary_word, incorrect_answer_2)
        user.practice(:definition, vocabulary_word, incorrect_answer_1)
        user.practice(:definition, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.definition_correct).to eq(0)
        expect(user.user_vocabulary_words.first.definition_attempted).to eq(6)
      end
    end # practicing definition

    context "practicing spoken" do

      let(:correct_answer_1) { vocabulary_word.main }
      let(:incorrect_answer_1) { vocabulary_word.main + "123" }
      let(:incorrect_answer_2) { vocabulary_word.main + "abc" }

      it "adds one to chinese_to_english_attempted" do
        user.practice(:spoken, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.spoken_attempted).to eq(1)
      end

      it "doesn't add 1 to correct if the answer is not correct" do
        user.practice(:spoken, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.spoken_correct).to eq(0)
      end

      it "adds 1 to correct if the answer is correct" do 
        user.practice(:spoken, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.spoken_correct).to eq(1)
      end

      it  "works if user answers correctly twice in a row" do
        user.practice(:spoken, vocabulary_word, correct_answer_1)
        user.practice(:spoken, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.spoken_correct).to eq(2)
        expect(user.user_vocabulary_words.first.spoken_attempted).to eq(2)
      end

      it "works with a mix of correct and incorrect answers" do
        user.practice(:spoken, vocabulary_word, correct_answer_1)
        user.practice(:spoken, vocabulary_word, correct_answer_1)
        user.practice(:spoken, vocabulary_word, incorrect_answer_1)
        user.practice(:spoken, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.spoken_correct).to eq(2)
        expect(user.user_vocabulary_words.first.spoken_attempted).to eq(4)
      end

      it "works with a mix of more correct and incorrect answers" do
        user.practice(:spoken, vocabulary_word, incorrect_answer_1)
        user.practice(:spoken, vocabulary_word, correct_answer_1)
        user.practice(:spoken, vocabulary_word, correct_answer_1)
        user.practice(:spoken, vocabulary_word, incorrect_answer_1)
        user.practice(:spoken, vocabulary_word, incorrect_answer_2)
        user.practice(:spoken, vocabulary_word, incorrect_answer_2)
        user.practice(:spoken, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.spoken_correct).to eq(3)
        expect(user.user_vocabulary_words.first.spoken_attempted).to eq(7)
      end

      it "works with many incorrect answers" do
        user.practice(:spoken, vocabulary_word, incorrect_answer_1)
        user.practice(:spoken, vocabulary_word, incorrect_answer_2)
        user.practice(:spoken, vocabulary_word, incorrect_answer_2)
        user.practice(:spoken, vocabulary_word, incorrect_answer_2)
        user.practice(:spoken, vocabulary_word, incorrect_answer_1)
        user.practice(:spoken, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.spoken_correct).to eq(0)
        expect(user.user_vocabulary_words.first.spoken_attempted).to eq(6)
      end
    end # practicing spoken

    context "practicing spelling" do

      let(:correct_answer_1) { vocabulary_word.main }
      let(:incorrect_answer_1) { vocabulary_word.main + "123" }
      let(:incorrect_answer_2) { vocabulary_word.main + "abc" }

      it "adds one to spelling_attempted" do
        user.practice(:spelling, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.spelling_attempted).to eq(1)
      end

      it "doesn't add 1 to correct if the answer is not correct" do
        user.practice(:spelling, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.spelling_correct).to eq(0)
      end

      it "adds 1 to correct if the answer is correct" do 
        user.practice(:spelling, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.spelling_correct).to eq(1)
      end

      it  "works if user answers correctly twice in a row" do
        user.practice(:spelling, vocabulary_word, correct_answer_1)
        user.practice(:spelling, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.spelling_correct).to eq(2)
        expect(user.user_vocabulary_words.first.spelling_attempted).to eq(2)
      end

      it "works with a mix of correct and incorrect answers" do
        user.practice(:spelling, vocabulary_word, correct_answer_1)
        user.practice(:spelling, vocabulary_word, correct_answer_1)
        user.practice(:spelling, vocabulary_word, incorrect_answer_1)
        user.practice(:spelling, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.spelling_correct).to eq(2)
        expect(user.user_vocabulary_words.first.spelling_attempted).to eq(4)
      end

      it "works with a mix of more correct and incorrect answers" do
        user.practice(:spelling, vocabulary_word, incorrect_answer_1)
        user.practice(:spelling, vocabulary_word, correct_answer_1)
        user.practice(:spelling, vocabulary_word, correct_answer_1)
        user.practice(:spelling, vocabulary_word, incorrect_answer_1)
        user.practice(:spelling, vocabulary_word, incorrect_answer_2)
        user.practice(:spelling, vocabulary_word, incorrect_answer_2)
        user.practice(:spelling, vocabulary_word, correct_answer_1)
        expect(user.user_vocabulary_words.first.spelling_correct).to eq(3)
        expect(user.user_vocabulary_words.first.spelling_attempted).to eq(7)
      end

      it "works with many incorrect answers" do
        user.practice(:spelling, vocabulary_word, incorrect_answer_1)
        user.practice(:spelling, vocabulary_word, incorrect_answer_2)
        user.practice(:spelling, vocabulary_word, incorrect_answer_2)
        user.practice(:spelling, vocabulary_word, incorrect_answer_2)
        user.practice(:spelling, vocabulary_word, incorrect_answer_1)
        user.practice(:spelling, vocabulary_word, incorrect_answer_1)
        expect(user.user_vocabulary_words.first.spelling_correct).to eq(0)
        expect(user.user_vocabulary_words.first.spelling_attempted).to eq(6)
      end
    end # practicing spelling
  end

  describe "#leveled_up?(points_just_added)" do
    let(:level_1) { Fabricate(:level, number: 1, points: 0) }
    let(:level_2) { Fabricate(:level, number: 2, points: 100) }
    let(:user) { Fabricate(:user, level: 1) }

    it "returns false if user did not just level up" do
      skip
      user.add_points(50)
      expect(user.leveled_up?(50)).to be_falsey
    end

    it "returns true if the user just leveled up" do
      skip
      user.add_points(100)
      expect(user.leveled_up?(100)).to be_truthy
    end
  end



end