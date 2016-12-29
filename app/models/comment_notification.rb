class CommentNotification < ActiveRecord::Base
  before_create :generate_random_slug

  belongs_to :comment
  belongs_to :user

  default_scope { order('created_at DESC') }

  def self.all_unread
    where(read: false)
  end

  def self.mark_all_as_read
    ActiveRecord::Base.transaction do
      all_unread.each do |notification|
        notification.mark_as_read
      end
    end
  end

  def mark_as_read
    update_column(:read, true)
  end

  def toggle_read
    update_column(:read, !read?)
  end

  def to_param
    self.slug
  end

  private

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

end