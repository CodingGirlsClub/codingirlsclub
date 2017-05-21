class User < ApplicationRecord
  has_secure_password

  attr_accessor :promo_code # 虚拟属性，用户注册时判断邀请码使用
  attr_accessor :remember_token

  validates :name,       presence: true, length: { maximum: 50 }
  validates :email,      presence: true, length: { maximum: 180 },
                         format: { with: CGC::VALID_EMAIL_REGEX },
                         uniqueness: { case_sensitive: false }
  validates :password,   presence: true, length: { minimum: 6, maximum: 20 }
  validates :promo_code, presence: true, length: { maximum: 15 }

  before_save :downcase_email

  # 记录用户持久化
  def remember
    self.remember_token = CGC::Tools::Regular.remember_token
    update_attribute(:remember_digest, CGC::Tools::Regular.digest(remember_token))
  end

  # 校验 remember_token 与 digest 是否匹配
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def downcase_email
    email.downcase!
  end
end
