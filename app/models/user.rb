class User < ApplicationRecord
    before_save { email.downcase! }
    validates :name, presence: true, length: { maximum: 8 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
                            format: { with: VALID_EMAIL_REGEX, allow_blank: true }, uniqueness: true
    has_secure_password
    validates :password, allow_blank: true, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: { message: "が一致しません" }
    validates :grade, numericality: {allow_nil: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3}
end