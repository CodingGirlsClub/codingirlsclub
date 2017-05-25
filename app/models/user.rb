class User < ApplicationRecord
  has_secure_password

  attr_accessor :promo_code       # 虚拟属性，用户注册时判断邀请码使用
  attr_accessor :activation_token # 虚拟属性，用户注册时激活帐号使用
  attr_accessor :remember_token   # 虚拟属性，用户登录时记录我使用

  validates :name,       presence: true, length: { maximum: 50 }
  validates :email,      presence: true, length: { maximum: 180 },
                         format: { with: CGC::Tools::Regular::VALID_EMAIL_REGEX },
                         uniqueness: { case_sensitive: false }
  validates :password,   presence: true, length: { minimum: 6, maximum: 20 }
  validates :promo_code, presence: true, length: { maximum: 15 }

  before_save :downcase_email
  before_create :create_activation_digest

  # 记录用户持久化
  def remember
    self.remember_token = CGC::Tools::Regular.user_new_token
    update_attribute(:remember_digest, CGC::Tools::Regular.user_digest(remember_token))
  end

  # 校验 remember_token 与 digest 是否匹配
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # 激活帐号
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 发送激活邮件
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token  = CGC::Tools::Regular.user_new_token
    self.activation_digest = CGC::Tools::Regular.user_digest(activation_token)
  end
end
