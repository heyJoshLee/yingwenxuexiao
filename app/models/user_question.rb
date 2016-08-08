class UserQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  belongs_to :choice


  def correct?
    choice.correct?
  end
end