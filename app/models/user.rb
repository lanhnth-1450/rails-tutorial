class User < ApplicationRecord
  belongs_to :school

  before_save :email_downcase

  validates :name, presence: true,
    length: {maximum: Settings.name.maximum}

  ATTR = %i(name email password password_confirmation school_id)

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true,
    length: {maximum: Settings.email.maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  has_secure_password

  validates :password, presence: true,
  length: {minimum: Settings.password.minimum}

  private
  def email_downcase
    email.downcase!
  end
end
