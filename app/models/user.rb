class User < ApplicationRecord
    has_many :articles, dependent: :destroy
    has_many :favorites
    attr_accessor :remember_token, :reset_token
    before_save :downcase_email

    validates :name, 
        presence: true, 
        length: { maximum: 8 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :email, 
        presence: true, 
        length: { maximum: 255 }, 
        format: { with: VALID_EMAIL_REGEX, allow_blank: true }, 
        uniqueness: true

    has_secure_password

    validates :password, 
        allow_blank: true, 
        presence: true, 
        length: { minimum: 6 }

    validates :password,
        presence: true,
        if: :password_was_entered?,
        on: :update

    validates :password_confirmation, 
        presence: true,
        on: :create

    validates :grade, 
        numericality: { allow_nil: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }

    mount_uploader :icon, ImageUploader

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

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def password_was_entered?
        password_confirmation.present?
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update_columns(reset_digest: User.digest(reset_token),
                reset_sent_at: Time.zone.now)
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    private

        def downcase_email
            self.email = email.downcase
        end
end