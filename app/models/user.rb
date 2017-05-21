class User < ApplicationRecord
  has_secure_password

  attr_accessor :promo_code # 虚拟属性，用户注册时判断邀请码使用

  validates :name,       presence: true, length: { maximum: 50 }
  validates :email,      presence: true, length: { maximum: 180 },
                         format: { with: CGC::VALID_EMAIL_REGEX },
                         uniqueness: { case_sensitive: false }
  validates :password,   presence: true, length: { minimum: 6, maximum: 20 }
  validates :promo_code, presence: true, length: { maximum: 15 }

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
