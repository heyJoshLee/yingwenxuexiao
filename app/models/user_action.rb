class UserAction < ActiveRecord::Base
  before_create :generate_random_slug

  belongs_to :user

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

  def self.create_user_action(user_id, options={})
    user = User.find(user_id)
    if options[:action_type] == "completed lesson" 
      create_complete_lesson_log(user, options)
    elsif options[:action_type] == "signed up"
      create_signed_up_log(user)
    end
  end

  private

  def self.create_signed_up_log(user)
    u = UserAction.new
    u.body = "#{user.email} signed up."
    u.action_type = "signed up"
    u.save
  end

  def self.create_complete_lesson_log(user, options)
    user_action = UserAction.new
    output_string = ""
    if options[:action_type] = "completed lesson"
      if options[:lesson_id]
        l = Lesson.find(options[:lesson_id])
        output_string = "#{user.email} completed lesson #{l.name} in #{l.course.name}\n\n courses/#{l.course.slug}/lessons/#{l.slug}"
      else
        output_string = "#{user.email} completed lesson"
      end
    end
    user_action.user_id = user.id
    user_action.action_type = options[:action_type]
    user_action.body = output_string
    user_action.save
  end



 
end