class Notification < ActiveRecord::Base

  belongs_to :user, foreign_key: "sender_id", class_name: "User"
  belongs_to :user, foreign_key: "received_id", class_name: "User"
  default_scope { order('created_at DESC') }

  before_create :generate_random_slug

  validates :subject, presence: true, length: {minimum: 3}
  validates :body, presence: true, length: {minimum: 3}
  validates :receiver_id, presence: true


  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

  def self.sent_admin_notifications
    output = pluck(:subject, :body).uniq.each_with_object([]) do |msg, o|
      o << {subject: msg[0], body: msg[1] }
    end
    output
  end

end