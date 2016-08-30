class PagesController < ApplicationController
  before_action :set_questions, only: [:help]

  def index
    render layout: "no_nav"
  end

  def upgrade
    render layout: "upgrade"
  end


  def careers
    add_breadcrumb "Careers"
  end

  def our_method
    add_breadcrumb "Our Method"
  end

  private

  def set_questions
    @questions = [
      {
        question: "What is the difference between a free and premium account?",
        answer: "A free account allows you to post comments on articles. A premium account lets you view lessons, take quizzes and ask the teacher questions. Further, additional features are being developed for premium. If you want to improve your English, a premium membership is a must."
      },
      {
        question: "What are points?",
        answer: "Points show how active you are on Yingwenxuexiao.com. You can compare points with your friends to see who practices more"
      },
      {
        question: "How do I earn points?",
        answer: "Only premium members can earn points. You can earn points by taking quizzes, viewing lessons and practicing English."
      },
      {
        question: "Can I download lessons?",
        answer: "No, but you can view lesson on mobile, ipad, tablets, pc and mac as long as you have an Internet connection."
      },
      {
        question: "How do I cancel my premium account?",
        answer: "Go to your account page and change your account to 'free.' You will continue to have premium access until the next billing period."
      }
    ]

  end
end

