class CommentNotification < ActiveRecord::Base

  belongs_to :comment
  belongs_to :user

  def to_param
    self.slug
  end

  private

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

end