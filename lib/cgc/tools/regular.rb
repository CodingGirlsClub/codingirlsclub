module CGC
  module Tools
    module Regular
      # Email
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
      # 容易阅读的随机字母和数字
      UPCASE_CHARACTERS_READABLE = (('A'..'Z').to_a + ('0'..'9').to_a - %w[0 1 2 5 8 B I L O S Z]).freeze

      def self.match_email(email)
        email.to_s.match VALID_EMAIL_REGEX
      end

      def self.user_digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end

      def self.user_new_token
        SecureRandom.urlsafe_base64
      end

      # 容易阅读的随机字母和数字
      def self.random_charcator_readable(num)
        UPCASE_CHARACTERS_READABLE.sample(num).join('')
      end
    end
  end
end
