class User < ApplicationRecord
    attr_accessor :remember_token
    before_save { email.downcase! }
    validates :name, presence: true, length: { maximum: 8 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
                            format: { with: VALID_EMAIL_REGEX, allow_blank: true }, uniqueness: true
    has_secure_password
    validates :password, allow_blank: true, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: { message: "が一致しません" }
    validates :grade, numericality: { allow_nil: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }

    class << self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
            BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end
        
        def new_token
            SecureRandom.urlsafe_base64
        end
    end
        
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end
end