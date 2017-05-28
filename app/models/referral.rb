class Referral < ApplicationRecord
  # category_system: 系统类邀请码， category_user: 用户类邀请码
  enum category: { category_system: 0, category_user: 1 }
end
