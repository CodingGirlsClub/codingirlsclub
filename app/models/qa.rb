class Qa < ApplicationRecord
  include AASM

  # 问题类型，AmbassadorQa: 校园大使申请
  CATEGORIES_NAME = %w(AmbassadorQa)

  validates :title,       presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :category,    presence: true

  has_many :questions

  # 问题状态
  aasm column: :status, no_direct_assignment: true do
    state :status_fresh, initial: true # 草稿
    state :status_enabled              # 启用
    state :status_disabled             # 废弃

    # 启用
    event :do_status_enabled do
      transitions from: :status_fresh, to: :status_enabled
    end

    # 废弃
    event :do_status_disabled do
      transitions from: [:status_fresh, :status_enabled], to: :status_disabled
    end
  end
end
