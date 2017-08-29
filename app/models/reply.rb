class Reply < ActiveRecord::Base
  belongs_to :comment
  belongs_to :author, foreign_key: "user_id", class_name: "User"

  validates :body, presence: true, length: {minimum: 1, maximum: 500}

  after_create :create_notification


  # creates notification whenever a reply is created. notification
  # is sent to the original author of the comment

  def create_notification
    Notification.create(
        subject: "#{author.name} just replied to your comment.", 
        receiver_id: comment.author.id,
        sender_id: author.id,
        body: %Q{
      "#{author.name}" just replied to your comment.<br/><br/>
      "#{body}"<br/><br/>
      #{create_link}})
  end


  # creates anchor tag in the body of the notification so user can
  # go to the comment. Use logic to determine if article or lesson
  # comment

  def create_link
    comment.commentable.class.name == "Lesson" ? create_lesson_link : create_article_link
  end

  def create_lesson_link
    %Q{<a href='#{ENV["ROOT_URL"]}/courses/#{comment.commentable.course.slug}/lessons/#{comment.commentable.slug}' > View the comment </a>}
  end

  def create_article_link
    %Q{<a href='#{ENV["ROOT_URL"]}/articles/#{comment.commentable.slug}' > View the comment </a>}    
  end


end