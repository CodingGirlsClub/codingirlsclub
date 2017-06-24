class Referral < ApplicationRecord
  # category_system: 系统类邀请码， category_user: 用户类邀请码
  enum category: { category_system: 0, category_user: 1 }

  before_create :set_code_and_expired_at
  validates_presence_of :user_id, :if => :category_user?

  private

  def set_code_and_expired_at
    self.code = generate_unique_code
  end

  def generate_unique_code
    10.times do |i|
      new_code = CGC::Tools::Regular.random_charcator_readable(5)
      if Referral.exists?(code: new_code)
        raise 'Could not generate a unique code for referral in 10 attempts!' if i >= 9
      else
        return new_code
      end
    end
  end
end
