class Ambassador < ApplicationRecord
  include AASM

  validates :user_id,           presence: true
  validates :self_introduction, presence: true, length: { maximum: 200 }
  validates :resume_url,        length: { maximum: 255 }

  belongs_to :user

  # 校园大使审核状态
  aasm column: :status, no_direct_assignment: true do
    state :status_fresh, initial: true # 待审核
    state :status_success              # 审核通过
    state :status_failed               # 审核不通过

    # 审核通过
    event :do_status_success do
      transitions from: [:status_fresh, :status_failed], to: :status_success
    end

    # 审核不通过
    event :do_status_failed do
      transitions from: :status_fresh, to: :status_failed
    end
  end
end
