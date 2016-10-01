class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :author, foreign_key: "user_id", class_name: "User"

  has_many :replies

  has_many :replies, -> {order("created_at DESC")}

  validates :body, presence: true, length: {minimum: 1, maximum: 500}

  before_create :generate_random_slug
  after_create :create_notification

  def create_notification
    User.where(role: "admin").each do |admin|
      notification = CommentNotification.new(comment_id: id, user: admin)
      notification.message = "New comment on article #{notification.comment.commentable.title}. #{notification.comment.author.name} says '#{notification.comment.body}'."
      notification.save
    end
  end

  private


  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

end