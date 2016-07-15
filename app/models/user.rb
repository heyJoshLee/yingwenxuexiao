class User < ActiveRecord::Base
  has_secure_password validations: false

  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false

  validates :name, presence: true, length: {minimum: 2, maximum: 50}
  validates :password, presence: true, length: {minimum: 5, maximum: 20}
end

