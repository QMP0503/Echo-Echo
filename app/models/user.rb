class User < ApplicationRecord
  belongs_to :classroom

  attr_accessor :password

  validates :email, presence: true, uniqueness: true
  validates :user_type, inclusion: { in: %w[student teacher] }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  before_save :encrypt_password, if: -> { password.present? }

  def name
    email.split("@").first.capitalize
  end

  def teacher?
    user_type == "teacher"
  end

  def student?
    user_type == "student"
  end

  private

  def encrypt_password
    self.encrypted_password = BCrypt::Password.create(password)
  end
end
