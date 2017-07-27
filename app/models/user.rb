class User < ApplicationRecord
  include AASM

  has_secure_password

  mount_uploader :avatar, AvatarUploader
  mount_uploader :id_photo, IdentityUploader

  attr_accessor :promo_code       # 虚拟属性，用户注册时判断邀请码使用
  attr_accessor :activation_token # 虚拟属性，用户注册时激活帐号使用
  attr_accessor :remember_token   # 虚拟属性，用户登录时记录我使用
  attr_accessor :reset_token      # 虚拟属性，用户找回密码时使用

  validates :name,       presence: true, length: { maximum: 50 }
  validates :email,      presence: true, length: { maximum: 180 },
                         format: { with: CGC::Tools::Regular::VALID_EMAIL_REGEX },
                         uniqueness: { case_sensitive: false }
  validates :password,   presence: true, length: { minimum: 6, maximum: 20 }, on: :create
  validates :promo_code, presence: true, length: { maximum: 15 }, on: :create

  validate :validate_promo_code, on: :create

  belongs_to :city, optional: true # Q:注册时要不要填城市
  belongs_to :university, optional: true

  has_one :ambassador
  has_one :mentor
  has_many :accounts
  has_many :answers

  before_save :downcase_email
  before_create :create_activation_digest
  after_create :send_activation_email

  # 用户性别， 0: 男，1: 女
  enum gender: { gender_male: 0, gender_female: 1 }

  # 用户学生证审核状态
  aasm column: :id_photo_status, no_direct_assignment: true do
    state :id_photo_status_fresh, initial: true # 待审核
    state :id_photo_status_success              # 审核通过
    state :id_photo_status_failed               # 审核未通过

    # 审核通过
    event :do_approve_success do
      transitions from: [:id_photo_status_fresh, :id_photo_status_failed], to: :id_photo_status_success
    end

    # 审核未通过
    event :do_approve_failed do
      transitions from: :id_photo_status_fresh, to: :id_photo_status_failed
    end
  end

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
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.current)
  end

  # 发送激活邮件
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # 重置密码
  def create_reset_digest
    self.reset_token = CGC::Tools::Regular.user_new_token
    update_attribute(:reset_digest,  CGC::Tools::Regular.user_digest(reset_token))
    update_attribute(:reset_sent_at, Time.current)
  end

  # 发送重置密码邮件
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # 检查重置密码 token 是否已过期
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # 根据邀请码生成邀请记录
  def generate_referral_with(promo_code)
    referral = Referral.find_by(code: promo_code)
    UserReferral.create!(code: promo_code, user_id: id, inviter_id: referral.user_id)
  end

  # 邀请码
  def referral
    return if new_record?
    Referral.find_or_create_by!(user_id: id, category: Referral.categories[:category_user])
  end

  private

  def validate_promo_code
    referral = Referral.find_by(code: promo_code)
    errors.add(:promo_code, :not_exist) and return if referral.nil?
    errors.add(:promo_code, :invalid) if referral.category_system? && referral.expired_at < Time.current
  end

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token  = CGC::Tools::Regular.user_new_token
    self.activation_digest = CGC::Tools::Regular.user_digest(activation_token)
  end
end
